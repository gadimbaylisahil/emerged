module V1
  class SettingsController < ApplicationController
    before_action :authenticate_with_token, only: %i[edit update]

    def edit
      setting = current_user.setting
      render json: setting, status: :ok
    end

    def update
      setting = current_user.setting
      if setting.update(setting_params)
        head(:ok)
      else
        head(:unprocessible_entity)
      end
    end

    private

    def setting_params
      params.require(:setting).permit(:email_follows?, :email_likes?, :emerged_emails?)
    end
  end
end
