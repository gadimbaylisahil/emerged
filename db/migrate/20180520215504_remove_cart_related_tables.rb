class RemoveCartRelatedTables < ActiveRecord::Migration[5.2]
  def change
    remove_reference :addresses, :purchase
    drop_table :cart_items
    drop_table :split_purchases
    drop_table :purchases
    drop_table :carts
  end
end
