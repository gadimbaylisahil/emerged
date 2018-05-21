module Notifiable
  extend ActiveSupport::Concern

  def create_notification(subject:, actor_user:, recipient_user:, activity_type:)
    Notification.create!(
                    actor_user: actor_user,
                    recipient_user: recipient_user,
                    activity_type: activity_type,
                    subject: subject
    )
  end
end