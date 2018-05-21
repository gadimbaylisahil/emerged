class Support < ApplicationRecord
  has_many :payment
  belongs_to :user
  belongs_to :supportable, polymorphic: true
end
