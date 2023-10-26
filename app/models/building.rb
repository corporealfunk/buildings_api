class Building < ApplicationRecord
  attr_reader :temp_custom_fields
  belongs_to :client

  validate :validate_custom_fields

  before_save :set_custom_fields

  # so, since we ar storing the custom fields here as JSON instead of
  # breaking them out into a tabe, we are going to do some fancy footwork
  # here to validate the fields and also set sensible defaults
  # this comes with some problems that might be fixed with more work.
  # We can't just call:
  #
  # Building.new(custom_field: 'value')
  #
  # That will throw an error because custom_field isn't an attr of the record
  #
  # we have to do:
  #
  # b = Building.new(client: <client>, ...an_db_attrs)
  #
  # # explicity set the custom fields
  # b.custom_field_name = 'value'
  # b.save!

  def set_custom_fields
    @temp_custom_fields ||= {}

    # if it is empty, set it to a default
    # of all our custom fields, with nil values
    if !self.custom_fields || self.custom_fields.keys.length == 0
      self.custom_fields = client.custom_fields.reduce({}) do |memo, custom_field|
        memo[custom_field.name] = nil
        memo
      end
    end

    self.custom_fields.merge!(@temp_custom_fields)
  end

  def validate_custom_fields
    # we need a set client to validate
    return if !client
    custom_fields = client.custom_fields

    # none set, so just bail
    return if !@temp_custom_fields || @temp_custom_fields.keys.length == 0

    custom_fields_by_name = custom_fields.reduce({}) do |memo, custom_field|
      memo[custom_field.name] = custom_field
      memo
    end

    # first: make sure that the keys are actually fields we can set
    extra_field_names = @temp_custom_fields.keys - custom_fields_by_name.keys
    if extra_field_names.length > 0
      errors.add(:custom_fields, "Extra custom fields found: #{extra_field_names.join(',')}")
      return
    end

    # next, make sure that the fields we did get validate for the type of field they are
    @temp_custom_fields.each do |key, value|
      custom_field = custom_fields_by_name[key]

      err_message = custom_field.validate(key, value)

      if err_message
        errors.add(:custom_fields, err_message)
      end
    end
  end

  # allow the setting of custom fields:
  def method_missing(name, *args, &block)
    # if the method doesn't end in "=" (setter) rais NoMethod
    raise NoMethodError, "No Method Buildings##{name}" if name[-1] != "="

    # we will set it
    @temp_custom_fields ||= {}
    @temp_custom_fields[name.to_s[0...-1]] = args[0]
  end

  # flatten out the custom fields
  def as_json(*)
    super.except('custom_fields').tap do |hash|
      hash[:client_name] = client.name
      custom_fields.each do |key, value|
        hash[key] = value
      end
    end
  end
end
