class Chat < ApplicationRecord
  has_many :messages, dependent: :destroy
  validates :identifier, presence: true, uniqueness: true, case_sensitive: false
end
