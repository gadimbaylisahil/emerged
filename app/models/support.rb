class Support < ApplicationRecord
  has_one :payment

  belongs_to :supporter, class_name: 'User'
  belongs_to :creator, class_name: 'User'
  belongs_to :supportable, polymorphic: true

  validates :amount_cents, presence: true, numericality: true
  monetize :amount_cents
end
