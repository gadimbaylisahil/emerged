class RenameTierPriceInRewards < ActiveRecord::Migration[5.2]
  def change
    rename_column :rewards, :tier_price_cents, :amount_cents
  end
end
