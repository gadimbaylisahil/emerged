module V1
  class RewardsController < V1::ApplicationController
    before_action :authenticate_with_token, only: %i[index create update destroy]

    before_action :find_reward_for_public, only: %i[show]
    before_action :find_reward_for_current_user, only: %i[edit update destroy]

    def show
      render json: RewardSerializer.new(@reward).serialized_json, status: :ok
    end
    # Todo: fix this. Index should be visible for public too
    def index
      rewards = current_user.rewards
      render json: RewardSerializer.new(rewards).serialized_json, status: :ok
    end

    def create
      reward = current_user.rewards.new(reward_params)
      reward.save!
      render json: RewardSerializer.new(reward).serialized_json, status: :created
    end

    def update
      @reward.update!(reward_params)
      render json: RewardSerializer.new(@reward).serialized_json, status: :updated
    end

    def destroy
      @reward.destroy!
      head(:ok)
    end

    private

    def find_reward_for_current_user
      @reward = current_user.rewards.find_by!(id: params[:id])
    end

    def find_reward_for_public
      @reward = Reward.find_by!(id: params[:id])
    end

    def reward_params
      params.permit(:cover_photo, :variants, :title, :price, :images, :description, :shipping_cost, :category_id, :reward_type, :visible?, :charge_taxes?, images_attachments_attributes: [:id, :_destroy])
    end
  end
end
