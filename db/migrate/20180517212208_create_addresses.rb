class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :type
      t.string :street, null: false
      t.string :street_optional
      t.string :city, null: false
      t.string :state
      t.string :postal_code, null: false
      t.string :country, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :company
      t.references :purchase, foreign_key: true, index: true
      t.timestamps
    end
  end
end
