module V1
  class ApplicationController < JSONAPI::ResourceController
    include ExceptionHandler
    skip_before_action :verify_authenticity_token, raise: false
    def context
      {
          current_user: current_user
      }
    end
    
    def current_user
	    return nil unless auth_token
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
      return nil unless request.headers['Authorization'].present?
	    request.headers['Authorization']&.split(' ')&.last
    end

    def decoded_token
      JsonWebToken.decode(auth_token)
    end
  end
end

