class Activity < ApplicationRecord
  belongs_to :subject, polymorphic: true
  belongs_to :user

  validates :activity_type, presence: true
  validates :is_public, presence: true, default: false
end
