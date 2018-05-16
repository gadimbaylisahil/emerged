class SplitPurchase < ApplicationRecord
  belongs_to :purchase
  belongs_to :user

  has_many :cart_items

  after_create :set_total_price

  private

  def set_total_price
    self.total_cents = cart_items.sum(:total_price_cents)
  end
end
