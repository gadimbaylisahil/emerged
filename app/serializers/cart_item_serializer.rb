class CartItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :quantity
  belongs_to :cart
  belongs_to :reward

end
