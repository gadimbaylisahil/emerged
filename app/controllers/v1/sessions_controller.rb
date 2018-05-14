module V1
  class SessionsController < ApplicationController
    before_action :authenticate_with_token, only: %i[destroy]
    def create
      user = User.find_by(email: params[:email])

      if user&.valid_password?(params[:password])
        jwt = JsonWebToken.encode({user_id: user.id})
        render json: UserSerializer.new(user).serializable_hash.merge(token: jwt), status: :created
      else
        render json: {message: 'Username or password is incorrect.'}, status: :unauthorized
      end
    end

    def destroy
      render json: { message: 'You have been logged out', token: ''}, status: :ok
    end
  end
end