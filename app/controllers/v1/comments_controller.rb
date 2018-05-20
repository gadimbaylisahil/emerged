module V1
  class CommentsController < V1::ApplicationController
    include Trackable
    include Notifiable

    before_action :authenticate_with_token

    after_action  -> { create_activity(subject: find_resource,
                                       user: current_user,
                                       activity_type: activity_type) }, only: %i[create destroy]

    after_action -> { create_notification(subject: find_resource,
                                          actor_user: current_user,
                                          recipient_user: find_resource.user,
                                          activity_type: activity_type)}, only: %i[create]

    def create
      resource = find_resource
      comment = resource.comments.new(body: params[:body])
      comment.user = current_user
      comment.save!
      render json: CommentSerializer.new(comment), status: :created
    end

    def destroy
      resource = find_resource
      comment = resource.comments.find_by!(user: current_user, id: params[:id])
      comment.destroy
      head(:no_content)
    end

    private

    def find_resource
      if params[:story_id].present?
        Story.find_by!(id: params[:story_id])
      elsif params[:creation_id].present?
        Creation.find_by!(id: params[:creation_id])
      elsif params[:project_id].present?
        Project.find_by!(id: params[:project_id])
      end
    end

    def activity_type
      if action_name == 'create'
        'comment'
      else
        'remove comment'
      end
    end
  end
end


