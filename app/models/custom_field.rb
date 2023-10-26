class CustomField < ApplicationRecord
  TYPE_NUMBER = 'number'
  TYPE_STRING = 'string'
  TYPE_ENUM = 'enum'

  belongs_to :client
end
