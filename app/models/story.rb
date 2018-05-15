class Story < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :comments, as: :commentable
  has_one_attached :cover_photo

  acts_as_votable

  scope :published, -> { where(published: true) }
end
