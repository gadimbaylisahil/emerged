class Category < ApplicationRecord
  
  acts_as_followable
  
  has_many :creations
  
  validates :name, presence: true, length: { within: 3..30 }
end
