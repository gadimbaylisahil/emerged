class RemovePriceFromRewards < ActiveRecord::Migration[5.2]
  def change
    remove_column :rewards, :price_cents
    remove_column :rewards, :shipping_cost_cents
    remove_column :rewards, :price_currency
    remove_column :rewards, :shipping_cost_currency
  end
end
