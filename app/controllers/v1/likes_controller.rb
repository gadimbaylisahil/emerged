module V1
  class LikesController < V1::ApplicationController
    before_action :authenticate_with_token
    def create
      resource = find_resource
      resource.liked_by current_user
      head(:ok)
    end

    def destroy
      resource = find_resource
      resource.unliked_by current_user
      head(:ok)
    end

    private
    def find_resource
      if params[:story_id].present?
        Story.find(params[:story_id])
      elsif params[:creation_id].present?
        Creation.find(params[:creation_id])
      end
    end
  end
end