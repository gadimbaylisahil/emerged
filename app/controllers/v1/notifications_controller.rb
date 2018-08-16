module V1
  require 'notification_policy'

  class NotificationsController < V1::ApplicationController
    before_action :authenticate_with_token
    before_action :authorize_user, only: %i[get_related_resources]

    def destroy
      user = find_user
      user.notifications.where(read_at: nil).update(read_at: Time.zone.now)
      head(:no_content)
    end
    
    private
    
    def find_user
      User.find_by!(id: params[:id] || params[:user_id])
    end
    
    def authorize_user
      send("auth_#{action_name}".to_sym)
    end
    
    def auth_get_related_resources
      authorize User.find_by!(id: params[:user_id]), policy_class: NotificationPolicy
    end
  end
end
