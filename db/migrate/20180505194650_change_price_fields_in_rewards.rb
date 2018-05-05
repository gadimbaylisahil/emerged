class ChangePriceFieldsInRewards < ActiveRecord::Migration[5.2]
  def up
    remove_column :rewards, :price_cents
    remove_column :rewards, :shipping_cost_cents
    add_monetize  :rewards, :price, null: false, default: 0
    add_monetize  :rewards, :shipping_cost, null: false, default: 0
  end

  def down
    add_column :rewards, :price_cents, :integer, null: false, default: 0
    add_column :rewards, :shipping_cost_cents, :integer, null: false, default: 0
  end
end
