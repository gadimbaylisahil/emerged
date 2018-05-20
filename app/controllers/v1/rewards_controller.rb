module V1
  class RewardsController < V1::ApplicationController
    before_action :authenticate_with_token, only: %i[index create update destroy]
    def show
      reward = Reward.find_by!(id: params[:id])
      render json: RewardSerializer.new(reward).serialized_json, status: :ok
    end

    def index
      rewards = current_user.rewards
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

    def reward_params
      params.permit(:cover_photo, :variants, :title, :price, :images, :description, :shipping_cost, :category_id, :reward_type, :visible?, :charge_taxes?, images_attachments_attributes: [:id, :_destroy])
    end
  end
end
