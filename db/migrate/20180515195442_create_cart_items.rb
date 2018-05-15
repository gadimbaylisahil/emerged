class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.references :reward, foreign_key: true
      t.references :cart, foreign_key: true
      t.integer :quantity
      t.integer :unit_price_cents, default: 0, null: false
      t.integer :total_price_cents, default: 0, null: false

      t.timestamps
    end
  end
end
