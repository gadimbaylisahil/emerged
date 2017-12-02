class StoriesController < ApplicationController
  before_action :find_story, only: %w(edit show destroy update)

  def index
    @stories = Story.all
  end

  def show
  end

  def edit
  end

  def new
  end

  def update
  end

  def create
  end

  def destroy
  end

  private

  def find_story
    @story = Story.find(params[:id])
  end
  def story_params
    params.require(:stories).permit(:title, :body, :status, :bg_image)
  end
end
