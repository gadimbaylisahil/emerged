class V1::RewardsController < ApplicationController
  before_action :authenticate_with_token, only: %i[new create edit update destroy]
  before_action :get_reward, only: %i[show]
  before_action :find_reward, only: %i[edit update destroy]

  def index
    current_user.rewards
  end

  def new
    @reward = current_user.rewards.new
  end

  def create
    @reward = current_user.rewards.new(reward_params)
    if @reward.save!
      if params[:reward][:images]
        @reward.images.attach(params[:reward][:images])
      end
      flash[:success] = 'You have created a new Reward.'
      render_notification(flash[:success], 'success')
    else
      flash[:error] = @reward.errors.full_messages.first
      render_notification(flash[:error], 'danger')
    end
  end

  def edit; end

  def update
    if @reward.update!(reward_params)
      if params[:reward][:images]
        @reward.images.attach(params[:reward][:images])
      end
      flash[:success] = 'Reward has been updated.'
      render_notification(flash[:success], 'success')
    else
      flash[:error] = @reward.errors.full_messages.first
      render_notification(flash[:error], 'danger')
    end
  end

  def destroy
    @reward.delete
    flash[:success] = 'Reward has been deleted.'
    render_notification(flash[:success], 'success')
  end

  private
  def get_reward
    @reward = Reward.find(params[:reward_id] || params[:id])
  end

  def reward_params
    params.require(:reward).permit(:cover_photo, :variants, :title, :price, :images, :description, :shipping_cost, :category_id, :reward_type, :visible?, :charge_taxes?, images_attachments_attributes: [:id, :_destroy])
  end

  def find_reward
    @reward = current_user.rewards.find(params[:reward_id] || params[:id])
  end
end