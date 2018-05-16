class AddOrderToCartItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :cart_items, :order, index: true, foreign_key: false
  end
end
