class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :given_supports, foreign_key: 'supporter_id'
  has_many :received_supports, foreign_key: 'creator_id'

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

  store :settings, accessors: %i[receive_emails_for_likes
                                             receive_emails_for_follows
                                             receive_emails_from_emerged]

  acts_as_voter
  acts_as_followable
  acts_as_follower

  before_save :parameterize_username
  before_create :set_default_settings

  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { within: 6..40 }

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false }

  validates :first_name, presence: true
  validates :last_name,  presence: true

  def full_name
    [first_name, last_name].join(' ')
  end

  # TODO: Extract as service object
  def current_chat_with(other_user)
    chats.each do |chat|
      chat.subscriptions.each do |subscription|
        return chat if subscription.user.eql?(other_user)
      end
    end
    false
  end

  # TODO: Extract as service object
  def users_with_history
    users_with_history = []
    chats.each do |chat|
      users_with_history.concat(chat.subscriptions.where.not(user: self).map(&:user))
    end
    users_with_history.uniq
  end

  private

  def parameterize_username
    self.username = username.parameterize
  end

  def set_default_settings
    self.receive_emails_for_follows = true
    self.receive_emails_for_likes = true
    self.receive_emails_from_emerged = true
  end
end