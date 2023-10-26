class CreateBuildings < ActiveRecord::Migration[7.1]
  def change
    create_table :buildings do |t|
      t.references :client, null: false, foreign_key: true
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :zip
      t.json :custom_fields

      t.timestamps
    end
  end
end
