module V1
  class FollowsController < V1::ApplicationController
    include Trackable
    include Notifiable
    before_action :authenticate_with_token, except: %i[index get_related_resources]
    
    after_action  -> { create_activity(subject: find_user,
                                       user: current_user,
                                       activity_type: activity_type)}, only: %i[create destroy]

    after_action -> { create_notification(subject: find_user,
                                          actor_user: current_user,
                                          recipient_user: find_user,
                                          activity_type: activity_type)}, only: %i[create]
    def index
      user = find_user
      follows = user.follows
      render json: JSONAPI::ResourceSerializer.new(FollowResource).
          serialize_to_hash(FollowResource.new(follows, context)), status: :ok
    end
    
    def create
      user = find_user
      current_user.follow user
      head(:created)
    end

    def destroy
      user = find_user
      current_user.unfollow user
      head(:no_content)
    end

    private
    
    def find_user
      User.find_by!(id: params[:user_id])
    end

    def activity_type
      if action_name == 'create'
        'follow'
      else
        'unfollow'
      end
    end
  end
end