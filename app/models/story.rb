class Story < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  has_many :comments, as: :commentable, dependent: :destroy
  has_one_attached :cover_photo

  acts_as_votable
  validates :title,
            presence: true,
            length: { within: 4..50 }
  validates :content, presence: true

  scope :published, -> { where(published: true) }
end
