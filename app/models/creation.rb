class Creation < ApplicationRecord
  belongs_to :user

  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations
  # Alias for acts_as_taggable_on :tags you can pass options instead of default value :skills, :interests etc
  acts_as_taggable
  acts_as_votable

  has_one_attached :cover_photo

  accepts_nested_attributes_for :categories
  validates :content,
            length: { minimum: 300, message: 'must contain at least 300 characters.' }
  validates :title,
            length: { within: 10..60, message: 'must be between 10 to 60 characters.' }
  validates :description,
            length: { minimum: 100, message: 'must contain at least 100 characters.' }
end
