class User < ApplicationRecord
  include Clearance::User
  has_one :profile, dependent: :destroy
  has_one :setting, dependent: :destroy

  has_many :creations, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :chats, through: :subscriptions
  has_many :stories, dependent: :destroy
  has_many :rewards, dependent: :destroy

  has_one_attached :avatar
  has_one_attached :cover_photo
  acts_as_voter
  acts_as_tagger
  acts_as_followable
  acts_as_follower
  validates :username,
            uniqueness: { message: '%<value> is already taken.' },
            length: { within: 6..40, message: 'must be between 6 to 40 characters.' },
            case_sensitivity: false

  before_validation :set_username, on: :create
  before_update :parameterize_username

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

  def users_with_history
    users_with_history = []
    chats.each do |chat|
      users_with_history.concat(chat.subscriptions.where.not(user: self).map(&:user))
    end
    users_with_history.uniq
  end

  private

  def set_username
    self.username = (first_name + SecureRandom.random_number(10000).to_s).parameterize
  end

  def parameterize_username
    self.username = username.parameterize
  end
end
