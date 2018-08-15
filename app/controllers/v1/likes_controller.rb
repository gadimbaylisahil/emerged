module V1
  class LikesController < V1::ApplicationController
    include Trackable
    include Notifiable
    before_action :authenticate_with_token, only: %i[create destroy]

    after_action  -> { create_activity(subject: find_creation,
                                       user: current_user,
                                       activity_type: activity_type) }, only: %i[create]

    after_action -> { create_notification(subject: find_creation,
                                          actor_user: current_user,
                                          recipient_user: find_creation.user,
                                          activity_type: activity_type)}, only: %i[create]
    
    def create
      creation = find_creation
      creation.liked_by current_user
      creation.increment!(:likes_count, 1)
      head(:created)
    end

    def destroy
      creation = find_creation
      creation.unliked_by current_user
      creation.decrement!(:likes_count, 1)
      head(:no_content)
    end

    private

    def find_creation
      Creation.find_by(id: params[:creation_id])
    end

    def activity_type
      if action_name == 'create'
        'like'
      end
    end
  end
end