class User < ApplicationRecord
  include Clearance::User
  has_one :profile
  has_one :setting
  has_many :creations
  acts_as_tagger
  acts_as_followable
  acts_as_follower

  validates :username, uniqueness: true, case_sensitivity: false, message: "%{value} is already taken."

  def full_name
    [self.first_name, self.last_name].join(" ")
  end
end
