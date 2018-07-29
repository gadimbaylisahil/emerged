module V1
  class UsersController < V1::ApplicationController
    include Notifiable
    include Trackable
    before_action :authenticate_with_token, only: %i[update destroy]
    after_action  -> { create_activity(subject: current_user,
                                       user: current_user,
                                       activity_type: 'update') }, only: %i[update]

    def index
      users = User.all
      render json: UserSerializer.new(users).serialized_json, status: :ok
    end

    def show
      user = find_user
      render json: UserSerializer.new(user).serialized_json, status: :ok
    end

    def update
      current_user.update!(user_params)
      head(:ok)
    end

    def destroy
      current_user.destroy!
      head(:no_content)
    end

    private

    def user_params
      params.permit(:email, :avatar, :cover_photo, :password, :title, :about_me, :company, :username, :first_name, :last_name, :city, :country, :website, :display_name)
    end

    def find_user
      User.find_by!(id: params[:id])
    end
  end
end
