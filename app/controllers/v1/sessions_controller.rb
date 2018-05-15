module V1
  class SessionsController < V1::ApplicationController
    before_action :authenticate_with_token, only: %i[destroy]

    def create
      user = find_user
      authenticated = check_password(user)

      if authenticated
        jwt = generate_jwt_token(user)
        render json: UserSerializer.new(user).serializable_hash.merge(token: jwt), status: :created
      else
        render json: {message: 'Username or password is incorrect.'}, status: :unauthorized
      end

    end

    def destroy
      render json: { message: 'You have been logged out', token: ''}, status: :ok
    end

    private

    def find_user
      User.find_by!(email: params[:email])
    end

    def check_password(user)
      user&.valid_password?(params[:password])
    end

    def generate_jwt_token(user)
      JsonWebToken.encode({user_id: user.id})
    end
  end
end