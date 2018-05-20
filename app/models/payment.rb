class Payment < ApplicationRecord
  belongs_to :support
  belongs_to :user

  has_one :billing_address
  has_one :shipping_address
end
