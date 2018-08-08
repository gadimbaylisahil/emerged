module V1
  require 'notification_policy'

  class NotificationsController < V1::ApplicationController
    before_action :authenticate_with_token
    before_action :authorize_user, only: %i[show_relationship get_related_resources]

    private

    def authorize_user
      authorize User.find_by!(id: params[:user_id]), policy_class: NotificationPolicy
    end
  end
end
