module V1
  class ApplicationController < ActionController::API
    include ExceptionHandler
    include SerializedOptions
    def current_user
      User.find(decoded_token['user_id'])
    end

    def authenticate_with_token
      head(:unauthorized) unless user_signed_in?
    end

    private

    def user_signed_in?
      current_user.present?
    end

    def auth_token
      request.headers['Authorization']&.split(' ')&.last
    end

    def decoded_token
      JsonWebToken.decode(auth_token)
    end
  end
end

