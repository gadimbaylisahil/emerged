class Category < ApplicationRecord
  has_many :creations
  has_many :stories
  validates :name, presence: true, length: { within: 3..20 }
end
