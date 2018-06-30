module V1
  class NotificationsController < V1::ApplicationController
    before_action :authenticate_with_token

    def unread
      notifications = current_user.notifications.unread
      render json: NotificationSerializer.new(notifications).serialized_json, status: :ok
    end

    def index
      notifications = current_user.notifications
      mark_as_read
      render json: NotificationSerializer.new(notifications).serialized_json, status: :ok
    end

    private

    def mark_as_read
      notifications = current_user.notifications.unread
      notifications.update_all(read_at: Time.zone.now)
    end
  end
end
