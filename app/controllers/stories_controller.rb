class StoriesController < ApplicationController
  include Notifications
  layout :detect_layout

  before_action :find_story, only: %i[edit update destroy]
  before_action :get_story, only: %i[vote]
  before_action :require_login, except: %i[discover show vote]

  def discover; end

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
      flash[:success] = 'You have created a new Story.'
      render_notification(flash[:success], 'success')
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
      flash[:error] = @creation.errors.full_messages.first
      render_notification(flash[:error], 'danger')
    end
  end

  def destroy
    @story.delete
    flash[:success] = 'Story has been deleted.'
    render_notification(flash[:success], 'success')
  end

  def vote
    respond_to do |format|
      format.js
      format.html
      format.json
    end
    if !current_user.liked? @story
      @story.liked_by current_user
    elsif current_user.liked? @story
      @story.unliked_by current_user
    end
  end

  private

  def detect_layout
    case action_name
      when 'show'
        return 'application'
      else
        return 'dashboard'
    end
  end

  def find_story
    @story = current_user.stories.find(params[:id])
  end

  def get_story
    @story = Story.find(params[:id])
  end

  def story_params
    params.require(:story).permit(:content, :title, :cover_photo, :disable_comments, :sensitive_content, :tag_list)
  end
end
