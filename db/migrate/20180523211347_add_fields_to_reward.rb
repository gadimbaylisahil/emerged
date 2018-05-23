class AddFieldsToReward < ActiveRecord::Migration[5.2]
  def change
    add_column :rewards, :content, :text, null: false, default: ''
    change_column :rewards, :tier_price_cents, :integer, default: 1000, null: false
  end
end
