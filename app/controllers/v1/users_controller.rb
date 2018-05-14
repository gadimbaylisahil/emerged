module V1
  class UsersController < ApplicationController
    include Notifiable
    include Trackable

    before_action :authenticate_with_token, only: %i[follow unfollow dashboard edit update destroy]
    before_action :get_user, only: %i[show follow unfollow]
    after_action  :increment_visitors, only: %i[show]
    after_action  -> { create_activity(subject: subject_for_activity, user: current_user) }, only: %i[follow unfollow update]
    after_action -> { create_notification(subject: @user, actor_user: current_user, recipient_user: @user)}, only: %i[follow]

    def show
      render json: UserSerializer.new(current_user).serialized_json, status: :ok
    end

    def edit
      render json: UserSerializer.new(current_user), status: :ok
    end

    def update
      current_user.update!(user_params)
      render json: UserSerializer.new(current_user).serialized_json, status: :updated
    end

    def destroy
      current_user.destroy!
      render json: { message: 'You account has been deleted'}, status: :ok
    end

    private

    def user_params
      params.require(:user).permit(:email, :avatar, :cover_photo, :password, :title, :about_me, :company, :username, :first_name, :last_name, :city, :country, :website, :display_name)
    end

    def get_user
      @user = User.find(params[:id])
    end

    def increment_visitors
      @user.increment_visitors
    end

    def subject_for_activity
      return current_user unless ['follow', 'unfollow'].include?(action_name)
      @user
    end
  end
end
