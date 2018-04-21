class SettingsController < ApplicationController
  layout 'dashboard'
  before_action :require_login

  def edit
    @setting = current_user.setting
  end

  def update
    @setting = current_user.setting
    @setting.update(setting_params)
  end

  private

  def setting_params
    params.require(:setting).permit(:email_follows?, :email_likes?, :emerged_emails?)
  end
end
