class NotificationsController < ApplicationController
  before_action :require_login
  layout false
  def index
    @notifications = Notification.unread.where(recipient_user: current_user)
    respond_to do |format|
      format.json { render json: @notifications }
    end
  end

  def mark_as_read
    @notifications = Notification.where(recipient_user: current_user)
    @notifications.update_all(read_at: Time.zone.now)
    render json: { success: true }
  end
end