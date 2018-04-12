class CreationsController < ApplicationController
  include Notifications
  layout :set_layout
  before_action :require_login, only: %i[new create edit update destroy]
  before_action :find_creation, only: %i[show edit update destroy]

  def discover
    @creations = Creation.all
  end

  def index
    @creations = current_user.creations
  end

  def show; end

  def new
    @creation = current_user.creations.new
  end

  def create
    @creation = current_user.creations.new(creation_params)
    if @creation.save
      flash[:success] = 'You have created a new Creation.'
      render_notification(flash[:success], 'success')
    else
      flash[:error] = @creation.errors.full_messages.first
      render_notification(flash[:error], 'danger')
    end
  end

  def edit; end

  def update
    if @creation.update(creation_params)
      flash[:success] = 'Creation has been updated.'
      render_notification(flash[:success], 'success')
    else
      flash[:error] = @creation.errors.full_messages.first
      render_notification(flash[:error], 'danger')
    end
  end

  def destroy
    @creation.delete
    flash[:success] = 'Creation has been deleted.'
    render_notification(flash[:success], 'success')
  end

  private

  def set_layout
    case action_name
    when 'index', 'new', 'edit'
      'dashboard'
    when 'show'
      'application'
    end
  end

  def find_creation
    @creation = current_user.creations.find(params[:id])
  end

  def creation_params
    params.require(:creation).permit(:user, :title, :content, :description, :license, :tag_list, :cover_photo, :disable_comments, :sensitive_content, :category_ids)
  end
end
