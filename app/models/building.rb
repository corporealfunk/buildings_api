class Building < ApplicationRecord
  belongs_to :client

  def as_json(*)
    super.except('custom_fields').tap do |hash|
      hash[:client_name] = client.name
      custom_fields.each do |key, value|
        hash[key] = value
      end
    end
  end
end
