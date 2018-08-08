module V1
  class CreationsController < V1::ApplicationController
    include Trackable
    impressionist actions: %i[show]
    before_action :authenticate_with_token, only: %i[create update destroy]
    before_action :authorize_user, only: %i[update destroy]

    private

    def authorize_user
      authorize Creation.find_by!(id: params[:id])
    end
    # sort_on :most_liked, type: :scope
    # sort_on :most_viewed, type: :scope
    # sort_on :recent, type: :scope
    # sort_on :most_discussed, type: :scope
    # sort_on :most_shared, type: :scope
    # sort_on :trending, type: :scope
    #
    
    # after_action  -> { create_activity(subject: subject_for_activity,
    #                                    user: current_user,
    #                                    activity_type: activity_type) }, only: %i[create update]
    
    # private
    #
    # def activity_type
    #   if action_name == 'create'
    #     'created'
    #   elsif action_name == 'update'
    #     'updated'
    #   end
    # end
    #
    # def subject_for_activity
    #   if action_name == 'create'
    #     current_user.creations.last
    #   elsif action_name == 'update'
    #     current_user.creations.find_by!(id: params[:id])
    #   end
    # end
    # def index
    #   process_request
    # end
    #
    # def show
    #   process_request
    # end
    #
    # def show_relationship
    #   process_request
    # end
    #
    # def create
    #   return unless verify_content_type_header
    #   process_request
    # end
    #
    # def create_relationship
    #   return unless verify_content_type_header
    #   process_request
    # end
    #
    # def update_relationship
    #   return unless verify_content_type_header
    #   process_request
    # end
    #
    # def update
    #   return unless verify_content_type_header
    #   process_request
    # end
    #
    # def destroy
    #   process_request
    # end
    #
    # def destroy_relationship
    #   process_request
    # end
    #
    # def get_related_resource
    #   process_request
    # end
    #
    # def get_related_resources
    #   process_request
    # end
  end
end
