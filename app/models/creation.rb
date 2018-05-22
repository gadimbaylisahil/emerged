class Creation < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :comments, as: :commentable, dependent: :destroy
  has_one_attached :cover_photo

  acts_as_votable

  validates :content, presence: true
  validates :title,
            presence: true,
            length: { within: 4..50 }

  validates :published, presence: true
  scope :published, -> { where(published: true) }
end
