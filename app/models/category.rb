class Category < ApplicationRecord
  has_many :creations
  validates :name, presence: true, length: { within: 3..20 }
end
