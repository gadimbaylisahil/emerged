module V1
  class NotificationsController < V1::ApplicationController
    before_action :authenticate_with_token
  end
end
