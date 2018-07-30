class License < ApplicationRecord
	has_many :creations
	
  validates :name, presence: true
  validates :description, presence: true
end
