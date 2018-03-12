class Category < ApplicationRecord
  has_many :categories_creations
  has_many :creations, through: :categories_creations
  validates :name, presence: true
end
