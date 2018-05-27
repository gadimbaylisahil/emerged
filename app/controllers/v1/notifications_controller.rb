module V1
  class NotificationsController < V1::ApplicationController
    before_action :authenticate_with_token

    def index
      notifications = current_user.notifications
      render json: NotificationSerializer.new(notifications).serialized_json, status: :ok
    end

    def mark_as_read
      notifications = current_user.notifications.unread
      notifications.update_all(read_at: Time.zone.now)
      head(:ok)
    end
  end
end
