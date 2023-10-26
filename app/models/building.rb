class Building < ApplicationRecord
  belongs_to :client

  validate :validate_custom_fields

  before_save :set_default_custom_fields

  # getter makes sure we always get an empty hash if it's not set
  def custom_fields
    self[:custom_fields] || {}
  end

  # before saving, we want to make sure we aways store a "full set"
  # of custom fields, even if they are nil
  def set_default_custom_fields
    default_custom_fields = client.custom_fields.reduce({}) do |memo, custom_field|
      memo[custom_field.name] = nil
      memo
    end

    self.custom_fields = default_custom_fields.merge(self.custom_fields)
  end

  # validate all the custom fields
  def validate_custom_fields
    # we need a set client to validate
    return if !client

    # none set, so just bail
    return if !self.custom_fields

    custom_fields_by_name = client.custom_fields.reduce({}) do |memo, custom_field|
      memo[custom_field.name] = custom_field
      memo
    end

    # first: make sure that the keys are actually fields we can set
    extra_field_names = self.custom_fields.keys - custom_fields_by_name.keys

    if extra_field_names.length > 0
      errors.add(:custom_fields, "Extra custom fields found: #{extra_field_names.join(',')}")
      return
    end

    # next, make sure that the fields we did get validate for the type of field they are
    self.custom_fields.each do |key, value|
      custom_field = custom_fields_by_name[key]

      err_message = custom_field.validate(key, value)

      if err_message
        errors.add(:custom_fields, err_message)
      end
    end
  end

  # flatten out the custom fields when we return json
  def as_json(*)
    super.except('custom_fields').tap do |hash|
      hash[:client_name] = client.name
      custom_fields.each do |key, value|
        hash[key] = value
      end
    end
  end
end
