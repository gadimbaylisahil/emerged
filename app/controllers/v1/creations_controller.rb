module V1
  class CreationsController < V1::ApplicationController
    include Notifiable
    include Trackable

    before_action :authenticate_with_token, only: %i[create update destroy like unlike]
    before_action :find_creation_for_public, only: %i[show publish unpulish like unlike]
    before_action :find_creation_for_current_user, only: %i[edit update destroy]
    after_action  :increment_views, only: %i[show]
    after_action -> { create_activity(subject: @creation, user: current_user) }, only: %i[like update create publish]
    after_action -> { create_notification(subject: @creation, actor_user: current_user, recipient_user: @creation.user)}, only: %i[like]

    def index
      creations = current_user.creations
      render json: CreationSerializer.new(creations).serialized_json, status: :ok
    end

    def show
      render json: CreationSerializer.new(@creation).serialized_json, status: :ok
    end

    def create
      creation = Creation.new(creation_params)
      creation.save!
      render json: CreationSerializer.new(creation).serialized_json, status: :created
    end

    def update
      @creation.update!(creation_params)
      render json: CreationSerializer.new(@creation).serialized_json, status: :updated
    end

    def destroy
      @creation.destroy!
      head(:ok)
    end

    private

    def find_creation_for_current_user
      @creation = current_user.creations.find(params[:id])
    end

    def find_creation_for_public
      @creation = Creation.find(params[:id])
    end

    def increment_views
      @creation.increment_view_counter
    end

    def creation_params
      params.permit(:user, :title, :content, :description, :published, :license, :cover_photo, :disable_comments, :sensitive_content, :category_id, :license_id)
    end
  end
end
