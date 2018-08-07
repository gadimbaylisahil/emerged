module V1
  class SessionsController < V1::ApplicationController
    before_action :authenticate_with_token, only: %i[destroy]
    skip_before_action :verify_authenticity_token
  
    def create
      user = find_user
      authenticated = check_password(user)

      if authenticated
        jwt = generate_jwt_token(user)
        context = {
            current_user: user
        }
        render json: JSONAPI::ResourceSerializer.new(UserResource).
            serialize_to_hash(UserResource.new(user, context)).merge(jwt: jwt)
      else
        render json: { message: 'Username or password is incorrect.' }, status: :unauthorized
      end
    end

    # No action necessary as JWT token will be removed on client side
    def destroy
      head(:no_content)
    end

    private

    def find_user
      User.find_by!(email: params[:email])
    end

    def check_password(user)
      user&.valid_password?(params[:password])
    end

    def generate_jwt_token(user)
      JsonWebToken.encode({ user_id: user.id })
    end
  end
end