class AddFullfillmentStatusToPurchases < ActiveRecord::Migration[5.2]
  def change
    add_column :purchases, :fullfillment_status, :string, default: 'pending', null: false
    add_column :split_purchases, :fullfillment_status, :string, default: 'pending', null: false
  end
end
