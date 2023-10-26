class CustomField < ApplicationRecord
  TYPE_NUMBER = 'number'
  TYPE_STRING = 'string'
  TYPE_ENUM = 'enum'

  belongs_to :client

  # validate a key/value pair based on the type of field we are
  # return of false indicates it passed, no error.
  # if it fails, a string error message is returned
  def validate(key, value)
    # strings can be anything:
    return false if field_type == TYPE_STRING

    # if no value, that's ok:
    return false if value == nil

    # maybe we could leverage rails validators, but this is fast
    # and easy for a proof of concept
    case field_type
    when TYPE_NUMBER
      begin
        begin
          Integer(value.to_s)
        rescue
          Float(value.to_s)
        end
      rescue
        return "#{key} must be a number"
      end
    when TYPE_ENUM
      if !enum_options.include?(value)
        return "#{key} must be one of: #{enum_options.join(', ')}"
      end
    end

    false
  end
end
