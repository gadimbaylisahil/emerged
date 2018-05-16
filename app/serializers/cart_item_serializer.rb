class CartItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :quantity, :total_price_cents
  belongs_to :cart
  belongs_to :reward
end
