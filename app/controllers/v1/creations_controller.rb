module V1
  class CreationsController < V1::ApplicationController
    include Trackable
    impressionist actions: %i[show]
    before_action :authenticate_with_token, only: %i[update destroy update_relationship create_relationship destroy_relationship]
    before_action :authorize_user, only: %i[update destroy update_relationship create_relationship destroy_relationship]

    private

    def authorize_user
	    send("auth_#{action_name}".to_sym)
    end

    def auth_update
	    authorize Creation.find_by!(id: params[:id] || params[:creation_id])
    end

    def auth_destroy
	    auth_update
    end
		
    def auth_create_relationship
	    auth_update
    end
    
		def auth_destroy_relationship
			auth_update
		end
		
		def auth_update_relationship
			auth_update
		end
  end
end
