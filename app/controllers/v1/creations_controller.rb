module V1
  class CreationsController < V1::ApplicationController
    include Trackable

    before_action :authenticate_with_token, except: %i[show index]

    after_action  -> { create_activity(subject: subject_for_activity,
                                       user: current_user,
                                       activity_type: activity_type) }, only: %i[create update]
    

    def index
      user = is_for_user? ? get_user : false
      creations = user ? user.creations : Creation.all
      render json: CreationSerializer.new(creations).serialized_json, status: :ok
    end

    def show
      creation = Creation.find_by!(id: params[:id])
      render json: CreationSerializer.new(creation, include_resources(%w[comments])).serialized_json, status: :ok
    end

    def create
      creation = current_user.creations.create!(creation_params)
      render json: CreationSerializer.new(creation).serialized_json, status: :created
    end

    def update
      creation = current_user.creations.find_by!(id: params[:id])
      creation.update!(creation_params)
      head(:ok)
    end

    def destroy
      creation = current_user.creations.find_by!(id: params[:id])
      creation.destroy
      head(:no_content)
    end

    private

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

    def subject_for_activity
      if action_name == 'create'
        current_user.creations.last
      elsif action_name == 'update'
        current_user.creations.find_by!(id: params[:id])
      end
    end
    
    def is_for_user?
      params[:user_id].present?
    end
    
    def get_user
      User.find!(params[:user_id])
    end
  end
end
