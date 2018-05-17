module V1
  class CreationsController < V1::ApplicationController
    include Trackable

    before_action :authenticate_with_token, only: %i[create update destroy like unlike]
    before_action :find_creation_for_public, only: %i[show publish unpulish like unlike]
    before_action :find_creation_for_current_user, only: %i[edit update destroy]

    after_action  -> { create_activity(subject: find_creation_for_current_user,
                                       user: current_user,
                                       activity_type: activity_type) }, only: %i[create update]
    def index
      creations = current_user.creations
      render json: CreationSerializer.new(creations).serialized_json, status: :ok
    end

    def show
      render json: CreationSerializer.new(@creation, include_resources(%w[comments])).serialized_json, status: :ok
    end

    def create
      creation = Creation.new(creation_params)
      creation.save!
      render json: CreationSerializer.new(creation).serialized_json, status: :created
    end

    def update
      @creation.update!(creation_params)
      head(:ok)
    end

    def destroy
      @creation.destroy
      head(:no_content)
    end

    private

    def find_creation_for_current_user
      @creation = current_user.creations.find(params[:id])
    end

    def find_creation_for_public
      @creation = Creation.find(params[:id])
    end

    def creation_params
      params.permit(:user, :title, :content, :description, :published, :license, :cover_photo, :disable_comments, :sensitive_content, :category_id, :license_id)
    end

    def activity_type
      if action_name == 'create'
        'created'
      elsif action_name == 'update'
        'updated'
      end
    end
  end
end
