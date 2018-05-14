module V1
  class RegistrationsController < ApplicationController
    def create
      user = User.new(user_params)
      if user.save!
        jwt = JsonWebToken.encode({user_id: user.id})
        render json: UserSerializer.new(user).serializable_hash.merge(token: jwt), status: :created
      end
    end

    private

    def user_params
      params.permit(:email, :password, :password_confirmation, :first_name, :last_name)
    end
  end
end