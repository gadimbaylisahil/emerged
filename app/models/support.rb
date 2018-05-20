class Support < ApplicationRecord
  has_one :payment
  belongs_to :user
  belongs_to :supportable, polymorphic: true
end
