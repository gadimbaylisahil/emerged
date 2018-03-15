class CreationsController < ApplicationController
  include Notifications
  layout 'dashboard', only: %i[index new edit]

  before_action :require_login, only: %i[new create edit update destroy]
  before_action :find_creation, except: %i[new create index discover]

  def discover
    @creations = Creation.all
  end

  def index
    @creations = current_user.creations
  end

  def show
  end

  def new
    @creation = current_user.creations.new
  end

  def create
    if @creation.create(creation_params)
      flash[:success] = 'You have created a new Creation.'
      render_notification(flash[:success], 'primary')
    else
      flash[:error] = @creation.errors.full_messages.first
      render_notification(flash[:error], 'warning')
    end
  end

  def edit
  end

  def update
    if @creation.update(creation_params)
      flash[:success] = "Creation has been updated."
      render_notification(flash[:success], 'primary')
    else
      flash[:error] = @creation.errors.full_messages.first
      render_notification(flash[:error], 'warning')
    end
  end

  def destroy
    if @creation.delete
      flash[:success] = "Creation has been deleted."
      render_notification(flash[:success], 'primary')
    end
  end

  private

  def find_creation
    @creation = current_user.creations.find(params[:id])
  end

  def creation_param
    params.require(:creation).permit(:user, :title, :content, :description, :license, :tag_list, :cover_image, :disable_comments, :sensitive_content)
  end
end
