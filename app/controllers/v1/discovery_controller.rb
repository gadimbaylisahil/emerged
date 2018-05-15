module V1
  class DiscoveryController < V1::ApplicationController
    def creations
      creations = Creation.published
      render json: CreationSerializer.new(creations).serialized_json, status: :ok
    end

    def stories
      stories = Story.published
      render json: StorySerializer.new(stories).serialized_json, status: :ok
    end
  end
end

