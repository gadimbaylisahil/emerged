class ChangeForeignKeyInCartItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :cart_items, :order_id
    add_column :cart_items, :purchase_id, :integer
    add_column :cart_items, :split_purchase_id, :integer
  end
end
