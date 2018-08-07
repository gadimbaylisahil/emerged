module V1
  class UsersController < V1::ApplicationController
    include Trackable
    # TODO: update relationship endpoints should be authenticated
    before_action :authenticate_with_token, only: %i[update destroy]
    after_action  -> { create_activity(subject: current_user,
                                       user: current_user,
                                       activity_type: 'update') }, only: %i[update]
    
  end
end
