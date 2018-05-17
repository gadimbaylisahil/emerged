module V1
  class StoriesController < V1::ApplicationController
    include Trackable
    include Notifiable

    before_action :authenticate_with_token, except: %i[show]
    before_action :find_story_for_current_user, only: %i[update destroy publish unpublish]
    before_action :find_story_for_public, only: %i[show like unlike]

    after_action -> { create_activity(subject: @story, user: current_user) }, only: %i[like unlike publish unpublish update create]
    after_action -> { create_notification(subject: @story, actor_user: current_user, recipient_user: @story.user)}, only: %i[like]

    def index
      stories = current_user.stories.all
      render json: StorySerializer.new(stories).serialized_json, status: :ok
    end

    def show
      render json: StorySerializer.new(@story).serialized_json, status: :ok
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
      @story.destroy!
      head(:no_content)
    end

    private

    def find_story_for_current_user
      @story = current_user.stories.find_by!(id: params[:story_id])
    end

    def find_story_for_public
      @story = Story.find_by!(id: params[:story_id])
    end

    def story_params
      params.permit(:content, :title, :cover_photo, :published, :disable_comments, :sensitive_content, :category_id)
    end
  end
end
