module V1
  class RewardsController < V1::ApplicationController
    before_action :authenticate_with_token, only: %i[create update destroy]

    def show
      user = find_user
      reward = user.rewards.find_by!(id: params[:id])
      render json: RewardSerializer.new(reward).serialized_json, status: :ok
    end

    def index
      user = find_user
      rewards = user.rewards
      render json: RewardSerializer.new(rewards).serialized_json, status: :ok
    end

    def create
      reward = current_user.rewards.create!(reward_params)
      render json: RewardSerializer.new(reward).serialized_json, status: :created
    end

    def update
      reward = current_user.rewards.find_by!(id: params[:id])
      reward.update!(reward_params)
      head(:ok)
    end

    def destroy
      reward = current_user.rewards.find_by!(id: params[:id])
      reward.destroy
      head(:no_content)
    end

    private

    def find_user
      User.find_by!(id: params[:user_id])
    end

    def reward_params
      params.permit(:cover_photo, :title, :amount_cents,
                    :description, :content, :require_shipping, images_attachments_attributes: [:id, :_destroy])
    end
  end
end