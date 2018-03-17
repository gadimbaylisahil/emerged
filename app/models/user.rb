class User < ApplicationRecord
  include Clearance::User
  has_one :profile, dependent: :destroy
  has_one :setting, dependent: :destroy

  has_many :creations, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :subscriptions
  has_many :chats, through: :subscriptions
  acts_as_tagger
  acts_as_followable
  acts_as_follower
  validates :username,
            uniqueness: { message: '%<value> is already taken.' },
            length: { within: 6..40, message: 'must be between 6 to 40 characters.' },
            case_sensitivity: false

  before_validation :set_username, on: :create
  before_update :parameterize_username

  def full_name
    [first_name, last_name].join(' ')
  end

  private

  def set_username
    self.username = (first_name + SecureRandom.random_number(10000).to_s).parameterize
  end

  def parameterize
    self.username = username.parameterize
  end
end
