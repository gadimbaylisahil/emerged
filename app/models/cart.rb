class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :rewards, through: :cart_items
  has_many :orders

  def completed?
    purchases.where(status: 'completed').any?
  end
end
