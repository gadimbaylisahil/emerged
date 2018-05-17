class CartItem < ApplicationRecord
  belongs_to :reward
  belongs_to :purchase, optional: true
  belongs_to :split_purchase, optional: true
  belongs_to :cart, touch: true

  before_create :update_total_price
  before_update :update_total_price
  after_update :destroy_if_empty

  monetize :total_price_cents
  monetize :unit_price_cents
  private

  def update_total_price
    self.total_price_cents = unit_price_cents * quantity
  end

  def destroy_if_empty
    destroy if self.quantity == 0
  end
end
