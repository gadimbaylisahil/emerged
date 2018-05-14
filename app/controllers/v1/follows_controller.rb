module V1
  class FollowsController < ApplicationController
    before_action :authenticate_with_token

    def create
      user = find_user
      current_user.follow user
      render json: { message: "You have followed #{user.username}"}, status: :ok
    end

    def destroy
      user = find_user
      current_user.stop_following user
      render json: { message: "You have unfollowed #{user.username}"}, status: :ok
    end

    private
    def find_user
      User.find_by!(id: params[:user_id])
    end
  end
end