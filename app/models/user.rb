class User < ApplicationRecord
  include Clearance::User
  has_one :profile
  has_one :setting
  has_many :creations
  acts_as_tagger
  acts_as_followable
  acts_as_follower
  validates :username,
            uniqueness: {message: "%{value} is already taken."},
            length: {within: 6..40, message: "must be between 6 to 40 characters."},
            case_sensitivity: false

  before_validation :set_username, on: :create
  before_update :parameterize_username

  def full_name
    [self.first_name, self.last_name].join(" ")
  end

  private
  def set_username
    self.username = (self.first_name + "#{SecureRandom.random_number(10000)}").parameterize

  end

  def parameterize
    self.username = self.username.parameterize
  end
end
