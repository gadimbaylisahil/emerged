module V1
  class LikesController < V1::ApplicationController
    include Trackable
    include Notifiable
    before_action :authenticate_with_token

    after_action  -> { create_activity(subject: find_resource,
                                       user: current_user,
                                       activity_type: activity_type) }, only: %i[create]

    after_action -> { create_notification(subject: find_resource,
                                          actor_user: current_user,
                                          recipient_user: find_resource.user,
                                          activity_type: activity_type)}, only: %i[create]

    def create
      resource = find_resource
      resource.liked_by current_user
      head(:created)
    end

    def destroy
      resource = find_resource
      resource.unliked_by current_user
      head(:no_content)
    end

    private

    def find_resource
      Creation.find(params[:creation_id]) if params[:creation_id]
    end

    def activity_type
      if action_name == 'create'
        'like'
      end
    end
  end
end