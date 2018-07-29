module V1
  class CreationsController < V1::ApplicationController
    include Trackable
    include Brita
    include Pagy::Backend
    include LinkGenerator
    impressionist actions: %i[show]
    
    sort_on :most_liked, type: :scope
    sort_on :most_viewed, type: :scope
    sort_on :recent, type: :scope
    sort_on :most_discussed, type: :scope
    sort_on :most_shared, type: :scope
    sort_on :trending, type: :scope
    
    filter_on :category_id, type: :int
    filter_on :user_id, type: :int
    filter_on :subscribed, type: :scope
    filter_on :featured, type: :boolean
    filter_on :today, type: :scope
    filter_on :this_month, type: :scope
    filter_on :this_year, type: :scope
    filter_on :by_location, type: :scope
    
    before_action :authenticate_with_token, except: %i[show index]

    after_action  -> { create_activity(subject: subject_for_activity,
                                       user: current_user,
                                       activity_type: activity_type) }, only: %i[create update]
    

    def index
      @pagy, creations = pagy(filtrate(Creation.all))
      links = {
          self: self_link(@pagy.page),
          next: next_link(@pagy.next),
          prev: prev_link(@pagy.prev)
      }
      resources = {
		      user: {
				    fields: []
		      },
          comments: {
              fields: [:body]
          }
      }
      render json: CreationSerializer.new(creations, SerializationOption.run(resources, links)).serialized_json, status: :ok
    end

    def show
      resources = {
		      user: {
				    fields: []
		      },
          comments: {
              fields: [:body]
          }
      }
      creation = Creation.find_by!(id: params[:id])
      render json: CreationSerializer.new(creation, SerializationOption.run(resources)).serialized_json, status: :ok
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

    def following
      creations = Creation.followed_by(current_user)
      render json: CreationSerializer.new(creations).serialized_json, status: :ok
    end
    
    private

    def creation_params
      params.permit(:user, :title, :content,
                    :description, :published, :license,
                    :cover_photo, :disable_comments, :sensitive_content,
                    :category_id, :license_id, :is_story, :sort, :filters, :page)
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
  end
end
