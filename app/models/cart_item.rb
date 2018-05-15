class CartItem < ApplicationRecord
  belongs_to :reward
  belongs_to :cart
end
