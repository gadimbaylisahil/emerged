module V1
  class CreationsController < ApplicationController
    include Notifiable
    include Trackable

    before_action :authenticate_with_token, only: %i[new create edit update destroy like unlike]
    before_action :get_creation, only: %i[show publish unpulish like unlike]
    before_action :find_creation, only: %i[edit update destroy]
    after_action  :increment_views, only: %i[show]
    after_action -> { create_activity(subject: @creation, user: current_user) }, only: %i[like update create publish]
    after_action -> { create_notification(subject: @creation, actor_user: current_user, recipient_user: @creation.user)}, only: %i[like]

    def index
      @creations = current_user.creations
      render json: CreationSerializer.new(@creations).serialized_json, status: :ok
    end

    def show
      render json: CreationSerializer.new(@creation).serialized_json, status: :ok
    end

    def create
      @creation = Creation.new(creation_params)
      @creation.save!
      render json: CreationSerializer.new(@creation).serialized_json, status: :created
    end

    def edit
      render json: CreationSerializer.new(@creation).serialized_json, status: :ok
    end

    def update
      @creation.update!(creation_params)
      render json: CreationSerializer.new(@creation).serialized_json, status: :updated
    end

    def destroy
      @creation.destroy!
      head(:ok)
    end

    def like
      @creation.liked_by current_user
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
      @creation.update!(published?: false)
      head(:ok)
    end

    private

    def find_creation
      @creation = current_user.creations.find(params[:creation_id])
    end

    def get_creation
      @creation = Creation.find(params[:creation_id])
    end

    def increment_views
      @creation.increment_view_counter
    end

    def creation_params
      params.require(:creation).permit(:user, :title, :content, :description, :license, :cover_photo, :disable_comments, :sensitive_content, :category_id, :license_id)
    end
  end
end
