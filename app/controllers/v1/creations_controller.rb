module V1
  class CreationsController < V1::ApplicationController
    include Trackable
    impressionist actions: %i[show]
    
    # sort_on :most_liked, type: :scope
    # sort_on :most_viewed, type: :scope
    # sort_on :recent, type: :scope
    # sort_on :most_discussed, type: :scope
    # sort_on :most_shared, type: :scope
    # sort_on :trending, type: :scope
    #
    
    before_action :authenticate_with_token, only: %i[create update destroy]
    # after_action  -> { create_activity(subject: subject_for_activity,
    #                                    user: current_user,
    #                                    activity_type: activity_type) }, only: %i[create update]
    
    private

    def activity_type
      if action_name == 'create'
        'created'
      elsif action_name == 'update'
        'updated'
      end
    end

    def subject_for_activity
      if action_name == 'create'
        current_user.creations.last
      elsif action_name == 'update'
        current_user.creations.find_by!(id: params[:id])
      end
    end
  end
end
