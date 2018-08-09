module V1
  class RegistrationsController < V1::ApplicationController
    def create
      user = User.create!(user_attributes)
      jwt = generate_jwt_token(user)
      context = {
          current_user: user
      }
      render json: JSONAPI::ResourceSerializer.new(UserResource).
          serialize_to_hash(UserResource.new(user, context)).merge(token: jwt), status: :created
    end

    private

    def user_params
      params.require(:data).permit(:type, {
          attributes: [:email, :password, :password_confirmation, :first_name, :last_name, :username]
      })
    end
    
    def user_attributes
      user_params[:attributes] || { }
    end

    def generate_jwt_token(user)
      JsonWebToken.encode({ user_id: user.id })
    end
  end
end