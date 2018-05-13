class V1::StoriesController < ApplicationController
  include Trackable
  include Notifiable

  before_action :find_story, only: %i[edit update destroy publish unpublish]
  before_action :get_story, only: %i[like unlike]
  before_action :authenticate_with_token, except: %i[discover show]
  after_action  :increment_views, only: %i[show]
  after_action -> { create_activity(subject: @story, user: current_user) }, only: %i[like unlike publish unpublish update create]
  after_action -> { create_notification(subject: @story, actor_user: current_user, recipient_user: @story.user)}, only: %i[like]

  def show
    @story = Story.find(params[:id])
  end

  def index
    @stories = current_user.stories.all
  end

  def new
    @story = current_user.stories.new
  end

  def create
    @story = current_user.stories.new(story_params)
    if @story.save
      # flash[:success] = 'You have created a new Story.'
      # render_notification(flash[:success], 'success')
      redirect_to rewards_path
    else
      flash[:error] = @story.errors.full_messages.first
      render_notification(flash[:error], 'danger')
    end
  end

  def edit; end

  def update
    if @story.update(story_params)
      flash[:success] = 'Story has been updated.'
      render_notification(flash[:success], 'success')
    else
      flash[:error] = @story.errors.full_messages.first
      render_notification(flash[:error], 'danger')
    end
  end

  def destroy
    @story.delete
    flash[:success] = 'Story has been deleted.'
    render_notification(flash[:success], 'success')
  end

  def like
    @story.liked_by current_user
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render 'like', layout: nil }
    end
  end

  def unlike
    @story.unliked_by current_user
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render 'unlike', layout: nil }
    end
  end

  def publish
    @story.update_attributes(is_published: true)
  end

  def unpublish
    @story.update_attributes(is_published: false)
  end

  private

  def find_story
    @story = current_user.stories.find(params[:story_id] || params[:id])
  end

  def get_story
    @story = Story.find(params[:story_id] || params[:id])
  end

  def story_params
    params.require(:story).permit(:content, :title, :cover_photo, :disable_comments, :sensitive_content, :category_id)
  end

  def increment_views
    @story.increment_view_counter
  end
end
