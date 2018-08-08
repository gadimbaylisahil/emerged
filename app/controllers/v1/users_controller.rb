module V1
  class UsersController < V1::ApplicationController
    include Trackable
    before_action :authenticate_with_token, only: %i[update destroy]
    before_action :authorize_user, only: %i[update destroy]
    # before_action :authorise_user, only: %i[update destroy]
    # after_action  -> { create_activity(subject: current_user,
    #                                    user: current_user,
    #                                    activity_type: 'update') }, only: %i[update]
    #

    private

    def authorize_user
      authorize User.find(params[:id])
    end
  end
end
