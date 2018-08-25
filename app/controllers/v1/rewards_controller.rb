module V1
  class RewardsController < V1::ApplicationController
    before_action :authenticate_with_token, only: %i[create update destroy update_relationship create_relationship destroy_relationship]
    before_action :authorize_user, only: %i[update destroy update_relationship create_relationship destroy_relationship]

    private

    def authorize_user
      send("auth_#{action_name}".to_sym)
    end

    def auth_update
      authorize Reward.find_by!(id: params[:id] || params[:reward_id])
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