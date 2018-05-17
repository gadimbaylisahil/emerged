module V1
  class StoriesController < V1::ApplicationController
    include Trackable

    before_action :authenticate_with_token, except: %i[show]
    before_action :find_story_for_current_user, only: %i[update destroy publish unpublish]
    before_action :find_story_for_public, only: %i[show like unlike]

    after_action  -> { create_activity(subject: find_story_for_current_user,
                                       user: current_user,
                                       activity_type: activity_type) }, only: %i[create update]

    def index
      stories = current_user.stories.all
      render json: StorySerializer.new(stories).serialized_json, status: :ok
    end

    def show
      render json: StorySerializer.new(@story, include_resources(%w[comments])).serialized_json, status: :ok
    end

    def create
      story = current_user.stories.new(story_params)
      story.save!
      render json: StorySerializer.new(story).serialized_json, status: :created
    end

    def update
      @story.update!(story_params)
      head(:ok)
    end

    def destroy
      @story.destroy
      head(:no_content)
    end

    private

    def find_story_for_current_user
      @story = current_user.stories.find_by!(id: params[:id])
    end

    def find_story_for_public
      @story = Story.find_by!(id: params[:id])
    end

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
  end
end
