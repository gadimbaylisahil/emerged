class AddSellerIdsToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :seller_ids, :integer, array: true, default: []
  end
end
