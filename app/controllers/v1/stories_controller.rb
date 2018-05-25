module V1
  class StoriesController < V1::ApplicationController
    include Trackable

    before_action :authenticate_with_token, except: %i[show]

    after_action  -> { create_activity(subject: subject_for_activity,
                                       user: current_user,
                                       activity_type: activity_type) }, only: %i[create update]

    def index
      stories = current_user.stories
      render json: StorySerializer.new(stories).serialized_json, status: :ok
    end

    def show
      story = Story.find_by!(id: params[:id])
      render json: StorySerializer.new(story, include_resources(%w[comments])).serialized_json, status: :ok
    end

    def create
      story = current_user.stories.create!(story_params)
      render json: StorySerializer.new(story).serialized_json, status: :created
    end

    def update
      story = current_user.stories.find_by!(id: params[:id])
      story.update!(story_params)
      head(:ok)
    end

    def destroy
      story = current_user.stories.find_by!(id: params[:id])
      story.destroy
      head(:no_content)
    end

    private
    def story_params
      params.permit(:content, :title, :cover_photo, :published, :disable_comments, :sensitive_content, :category_id)
    end

    def activity_type
      if action_name == 'create'
        'created'
      elsif action_name == 'update'
        'updated'
      end
    end

    def subject_for_activity
      if action_name == 'create'
        current_user.stories.last
      elsif action_name == 'update'
        current_user.stories.find_by!(id: params[:id])
      end
    end
  end
end
