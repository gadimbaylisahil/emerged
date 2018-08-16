module V1
  class CommentsController < V1::ApplicationController
    include Trackable
    include Notifiable

    before_action :authenticate_with_token, only: %i[create destroy]

    after_action  -> { create_activity(subject: find_resource,
                                       user: current_user,
                                       activity_type: activity_type) }, only: %i[create destroy]

    after_action -> { create_notification(subject: find_resource,
                                          actor_user: current_user,
                                          recipient_user: find_resource.user,
                                          activity_type: activity_type)}, only: %i[create]

    def index
      resource = find_resource
      comments = resource.comments
      render json: JSONAPI::ResourceSerializer.new(CommentResource).
          serialize_to_hash(CommentResource.new(comments, context)), status: :ok
    end
    
    def create
      resource = find_resource
      comment = resource.comments.new(body: params[:data][:attributes][:body])
      comment.user = current_user
      comment.save!
      resource.increment!(:comments_count, 1)
      render json: JSONAPI::ResourceSerializer.new(CommentResource).
          serialize_to_hash(CommentResource.new(comment, context)), status: :created
    end

    def destroy
      resource = find_resource
      comment = resource.comments.find_by!(id: params[:id])
      authorize comment
      comment.destroy
      resource.decrement!(:comments_count, 1)
      head(:no_content)
    end

    private

    def find_resource
      raise ActiveRecord::RecordNotFound unless params[:creation_id]
      Creation.find_by!(id: params[:creation_id])
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


