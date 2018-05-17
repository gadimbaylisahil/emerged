module V1
  class CommentsController < V1::ApplicationController
    before_action :authenticate_with_token

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
      else
        Creation.find_by!(id: params[:creation_id])
      end
    end
  end
end


