module Notifications
  extend ActiveSupport::Concern

  def render_notification(message, type)
    render js: "notifications.showNotification('top', 'right', '#{type}', '#{message}');"
  end
end