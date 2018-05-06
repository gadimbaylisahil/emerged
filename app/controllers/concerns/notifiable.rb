module Notifiable
  extend ActiveSupport::Concern

  def create_notification(subject:, actor_user:, recipient_user:)
    Notification.create(
                    actor_user: actor_user,
                    recipient_user: recipient_user,
                    activity_type: action_name,
                    subject: subject
    )
  end
end