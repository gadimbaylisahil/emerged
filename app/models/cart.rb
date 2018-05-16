class Cart < ApplicationRecord
  belongs_to :user

  has_many :cart_items, dependent: :destroy
  has_many :rewards, through: :cart_items
  has_many :purchases

  def completed?
    purchases.where(status: 'completed').any?
  end
end
