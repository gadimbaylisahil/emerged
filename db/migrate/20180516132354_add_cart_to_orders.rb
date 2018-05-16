class AddCartToOrders < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :cart, foreign_key: true, index: true
  end
end
