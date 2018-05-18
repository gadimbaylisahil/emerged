class Purchase < ApplicationRecord
  belongs_to :cart
  belongs_to :user

  has_many :split_purchases
  has_many :cart_items
  has_one :shipping_address
  has_one :billing_address

  after_create :set_total_price

  private

  def set_total_price
    self.total_cents = cart_items.sum(:total_price_cents)
  end
end
