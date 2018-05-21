class AddShippingFieldToRewards < ActiveRecord::Migration[5.2]
  def change
    add_column :rewards, :require_shipping, :boolean, default: false, null: false
  end
end
