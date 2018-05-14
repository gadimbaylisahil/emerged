module V1
  class StoriesController < ApplicationController
    include Trackable
    include Notifiable
    before_action :authenticate_with_token, except: %i[show]
    before_action :find_story, only: %i[edit update destroy publish unpublish]
    before_action :get_story, only: %i[show like unlike]

    after_action  :increment_views, only: %i[show]
    after_action -> { create_activity(subject: @story, user: current_user) }, only: %i[like unlike publish unpublish update create]
    after_action -> { create_notification(subject: @story, actor_user: current_user, recipient_user: @story.user)}, only: %i[like]

    def show
      render json: StorySerializer.new(@story).serialized_json, status: :ok
    end

    def index
      stories = current_user.stories.all
      render json: StorySerializer.new(stories).serialized_json, status: :ok
    end

    def create
      story = current_user.stories.new(story_params)
      story.save!
      render json: StorySerializer.new(story).serialized_json, status: :ok
    end

    def edit
      render json: StorySerializer.new(@story).serialized_json, status: :ok
    end

    def update
      @story.update!(story_params)
      render json: StorySerializer.new(@story).serialized_json, status: :ok
    end

    def destroy
      @story.destroy!
      head(:ok)
    end

    def like
      @story.liked_by current_user
      head(:ok)
    end

    def unlike
      @creation.unliked_by current_user
      head(:ok)
    end

    def publish
      @creation.update!(published?: true)
      head(:ok)
    end

    def unpulish
      @story.update!(published?: false)
      head(:ok)
    end

    private

    def find_story
      @story = current_user.stories.find(params[:id])
    end

    def get_story
      @story = Story.find(params[:id])
    end

    def story_params
      params.require(:story).permit(:content, :title, :cover_photo, :disable_comments, :sensitive_content, :category_id)
    end

    def increment_views
      @story.increment_view_counter
    end
  end
end
