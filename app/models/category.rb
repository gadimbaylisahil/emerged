class Category < ApplicationRecord
  has_many :categorizations
  has_many :creations, through: :categorizations

  validates :name, presence: true
end
