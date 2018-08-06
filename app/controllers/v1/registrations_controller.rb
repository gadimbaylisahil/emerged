module V1
  class RegistrationsController < V1::ApplicationController
    def create
      user = User.create!(user_params)
      jwt = generate_jwt_token(user)
      render json: UserSerializer.new(user).serializable_hash.merge(token: jwt), status: :created
    end

    private

    def user_params
      params.permit(:email, :password, :password_confirmation, :first_name, :last_name, :username)
    end

    def generate_jwt_token(user)
      JsonWebToken.encode({ user_id: user.id })
    end
  end
end