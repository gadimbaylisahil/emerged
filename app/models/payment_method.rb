class PaymentMethod < ApplicationRecord
  validates :name, presence: true
  validates :shorthand, presence: true
end
