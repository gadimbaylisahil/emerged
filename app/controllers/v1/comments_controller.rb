module V1
  class CommentsController < ApplicationController
    before_action :authenticate_with_token

    def create
      resource = find_resource
      comment = resource.comments.new(comment_params)
      comment.user = current_user
      comment.save!
      render json: { message: 'Your comment has been submitted.' }, status: :ok
    end

    def destroy
      resource = find_resource
      comment = resource.comments.find_by!(user: current_user, id: params[:id])
      comment.destroy!
      render json: { message: 'Your comment has been removed.' }, status: :ok
    end

    private

    def find_resource
      if params[:story_id].present?
        Story.find_by!(id: params[:story_id])
      else
        Creation.find_by!(id: params[:creation_id])
      end
    end

    def comment_params
      params.permit(:body)
    end
  end
end


