class Creation < ApplicationRecord
  attr_reader :likes
  
  belongs_to :user
  belongs_to :category, optional: true

  has_many :comments, as: :commentable, dependent: :destroy
  has_one_attached :cover_photo

  acts_as_votable

  validates :content, presence: true
  validates :title,
            presence: true,
            length: { within: 4..50 }

  scope :published, -> { where(published: true) }
  scope :subscribed, -> (user_id) { where(category_id: User.find(user_id).following_by_type('Category').pluck(:id)) }
  scope :most_liked, -> { order(cached_votes_up: :desc) }
  
  def self.followed_by(user)
    following_ids = user.all_following.pluck(:id)
    where(user_id: following_ids)
  end
end
