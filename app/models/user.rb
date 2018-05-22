class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :setting, dependent: :destroy
  has_many :supports, as: :supportable
  has_many :notifications, foreign_key: :recipient_user_id, dependent: :destroy
  has_many :creations, dependent: :destroy
  has_many :messages, dependent: :nullify
  has_many :subscriptions, dependent: :destroy
  has_many :chats, through: :subscriptions
  has_many :stories, dependent: :destroy
  has_many :rewards, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :activities, dependent: :destroy

  has_one_attached :avatar
  has_one_attached :cover_photo

  acts_as_voter
  acts_as_followable
  acts_as_follower

  before_save :parameterize_username

  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { within: 6..40 }

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false }

  validates :first_name, presence: true
  validates :last_name,  presence: true

  # TODO: Extract as service object
  def current_chat_with(other_user)
    chats.each do |chat|
      chat.subscriptions.each do |subscription|
        return chat if subscription.user.eql?(other_user)
      end
    end
    false
  end

  def full_name
    [first_name, last_name].join(' ')
  end

  # TODO: Extract as service object
  def users_with_history
    users_with_history = []
    chats.each do |chat|
      users_with_history.concat(chat.subscriptions.where.not(user: self).map(&:user))
    end
    users_with_history.uniq
  end

  # TODO: Extract as service object
  def total_likes
    creation_likes = creations.inject(0) { |total, creation| total += creation.get_likes.size }
    story_likes = stories.inject(0) { |total, story| total += story.get_likes.size }
    creation_likes + story_likes
  end

  # TODO: Extract as service object
  def recent_activities(limit)
    activities.order('created_at DESC').limit(limit)
  end

  # TODO: Extract as service object
  def recent_public_activities(limit)
    activities.where(is_public: true).order('created_at DESC').limit(limit)
  end

  private

  def parameterize_username
    self.username = username.parameterize
  end
end