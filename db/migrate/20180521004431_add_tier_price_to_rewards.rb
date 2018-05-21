class AddTierPriceToRewards < ActiveRecord::Migration[5.2]
  def change
    remove_column :rewards, :visible
    add_column :rewards, :tier_price_cents, :integer, null: false, default: 1
  end
end
