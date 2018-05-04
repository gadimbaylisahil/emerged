module Notifications
  extend ActiveSupport::Concern

  def render_notification(message, type)
    render 'shared/notifications', layout: nil, locals: {type: type, message: message}
  end
end
