class Notification < ApplicationRecord
  belongs_to :recipient_user, class_name: 'User'
  belongs_to :actor_user, class_name: 'User', optional: true
  belongs_to :subject, polymorphic: true

  validates :activity_type, presence: true
  scope :unread, -> { where(read_at: nil) }
end
