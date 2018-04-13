class Creation < ApplicationRecord
  belongs_to :user

  has_many :categorizations, dependent: :destroy
  has_many :comments, as: :commentable
  has_many :categories, through: :categorizations
  has_one_attached :cover_photo

  # Alias for acts_as_taggable_on :tags you can pass options instead of default value :skills, :interests etc
  acts_as_taggable
  acts_as_votable

  accepts_nested_attributes_for :categories
  validates :content,
            length: { minimum: 300, message: 'must contain at least 300 characters.' }
  validates :title,
            length: { within: 6..50, message: 'must be between 10 to 50 characters.' }
  validates :description,
            length: { minimum: 100, message: 'must contain at least 100 characters.' }
end
