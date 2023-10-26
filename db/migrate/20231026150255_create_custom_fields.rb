class CreateCustomFields < ActiveRecord::Migration[7.1]
  def change
    create_table :custom_fields do |t|
      t.references :client, null: false, foreign_key: true
      t.string :type
      t.string :name
      t.json :enum_options

      t.timestamps
    end
  end
end
