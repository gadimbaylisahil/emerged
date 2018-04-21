class Category < ApplicationRecord
  has_many :creations
  has_many :stories
  has_many :rewards
  validates :name, presence: true
end
