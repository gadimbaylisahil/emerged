module V1
  class NotificationsController < V1::ApplicationController
    before_action :authenticate_with_token

    def index
      notifications = Notification.where(recipient_user: current_user)
      render json: NotificationSerializer.new(notifications).serialized_json, status: :ok
    end

    def mark_as_read
      notifications = Notification.unread.where(recipient_user: current_user)
      notifications.update_all(read_at: Time.zone.now)
      head(:ok)
    end
  end
end
