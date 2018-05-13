class V1::CreationsController < ApplicationController
  include Notifiable
  include Trackable

  before_action :authenticate_with_token, only: %i[new create edit update destroy like unlike]
  before_action :get_creation, only: %i[show publish unpulish like unlike]
  before_action :find_creation, only: %i[edit update destroy]
  after_action  :increment_views, only: %i[show]
  after_action -> { create_activity(subject: @creation, user: current_user) }, only: %i[like update create publish]
  after_action -> { create_notification(subject: @creation, actor_user: current_user, recipient_user: @creation.user)}, only: %i[like]

  def discover
    @creations = Creation.all
  end

  def index
    # @creations = current_user.creations
    @creations = Creation.all
    json_response(object: @creations)
  end

  def show; end

  def preview
  end

  def new
    @creation = Creation.new
  end

  def create
    @creation = Creation.new(creation_params)
    @creation.save
    json_response(object: @creation, status: :created)
  end

  def edit; end

  def update
    @creation.update(creation_params)
    json_response(object: @creation, status: :updated)
  end

  def destroy
    if @creation.delete
      head(:ok)
    else
      head(:unprocessible_entity)
    end
  end

  def like
    @creation.liked_by current_user
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render 'like', layout: nil }
    end
  end

  def unlike
    @creation.unliked_by current_user
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render 'unlike', layout: nil }
    end
  end

  def publish
    @creation.update(published?: true)
  end

  def unpulish
    @creation.update(published?: false)
  end
  private

  def find_creation
    @creation = current_user.creations.find(params[:creation_id] || params[:id])
  end

  def get_creation
    @creation = Creation.find(params[:creation_id] || params[:id])
  end

  def creation_params
    params.require(:creation).permit(:user, :title, :content, :description, :license, :cover_photo, :disable_comments, :sensitive_content, :category_id, :license_id)
  end

  def increment_views
    @creation.increment_view_counter
  end
end
