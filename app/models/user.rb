class User < ApplicationRecord
  include Clearance::User
  has_one :profile
  has_one :setting

  acts_as_tagger
  acts_as_followable
  acts_as_follower

  validates :company, presence: true
end
