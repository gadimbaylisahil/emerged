class Creation < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :comments, as: :commentable
  has_one_attached :cover_photo

  acts_as_votable

  validates :content, presence: true
  validates :title,
            length: { within: 4..50 }

  scope :published, -> { where(published: true) }
end
