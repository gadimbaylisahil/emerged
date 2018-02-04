class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_devise_parameters, if: :devise_controller?
  protected

  def configure_devise_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :role])
  end

  def after_sign_in_path_for(resource)
    case resource.role
      when 'artist'
        redirect_to artist_profiles_path
      when 'supporter'
        redirect_to supporter_profiles_path
    end
  end
end
