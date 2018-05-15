module V1
  class SettingsController < V1::ApplicationController
    before_action :authenticate_with_token, only: %i[edit update]

    def update
      setting = current_user.setting
      setting.update!(setting_params)
      render json: SettingSerializer.new(setting).serialized_json, status: :updated
    end

    private

    def setting_params
      params.require(:setting).permit(:receive_emails_for_likes, :receive_emails_for_follows, :receive_emails_from_emerged)
    end
  end
end
