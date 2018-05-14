module V1
  class SessionsController < ApplicationController
    def create
      user = User.find_by(email: params[:email])

      if user&.valid_password?(params[:password])
        jwt = JsonWebToken.encode({user_id: user.id})
        render json: user.attributes.merge(token: jwt), status: :created
      else
        head(:unauthorized)
      end
    end

    def destroy
    end
  end
end