class NotificationsController < ApplicationController
  before_action :authenticate_with_token

  def index
    @notifications = Notification.unread.where(recipient_user: current_user)
    json_response(object: @notifications)
  end

  def mark_as_read
    @notifications = Notification.where(recipient_user: current_user)
    @notifications.update_all(read_at: Time.zone.now)
    head(:ok)
  end
end