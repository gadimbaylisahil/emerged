class Category < ApplicationRecord
  
  acts_as_followable
  
  has_many :creations, inverse_of: :category
  
  validates :name, presence: true, length: { within: 3..30 }
end
