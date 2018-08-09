module V1
  class UsersController < V1::ApplicationController
    SKIP_AUTH_ON = ['comments', 'creations']
    include Trackable
    before_action :authenticate_with_token, only: %i[update destroy]
    before_action :authorize_user, only: %i[update destroy create_relationship destroy_relationship show_relationship]
    
    private

    def authorize_user
      send("auth_#{action_name}".to_sym)
    end
    
    def auth_update
      authorize User.find(params[:id] || params[:user_id])
    end
    
    def auth_destroy
      auth_update
    end
    
    def auth_show_relationship
      if SKIP_AUTH_ON.include?(params[:relationship])
        skip_authorization
      else
        auth_update
      end
    end
    
    def auth_create_relationship
      auth_update
    end
    
    def auth_destroy_relationship
      auth_update
    end
    
  end
end
