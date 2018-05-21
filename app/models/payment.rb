class Payment < ApplicationRecord
  belongs_to :support
  belongs_to :user

  has_one :billing_address
  has_one :shipping_address

  accepts_nested_attributes_for :billing_address
  accepts_nested_attributes_for :shipping_address

  validates :payment_method_id, presence: true

  monetize :amount_cents
end
