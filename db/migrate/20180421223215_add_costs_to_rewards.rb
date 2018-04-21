class AddCostsToRewards < ActiveRecord::Migration[5.2]
  def change
    add_column :rewards, :price_cents, :integer, null: false
    add_column :rewards, :shipping_cost_cents, :integer, null: false
  end
end
