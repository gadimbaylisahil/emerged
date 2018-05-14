module V1
  class DiscoveryController < ApplicationController
    def creations
      creations = Creation.all
      render json: CreationSerializer.new(creations).serialized_json, status: :ok
    end

    def stories
      stories = Story.all
      render json: StorySerializer.new(stories).serialized_json, status: :ok
    end
  end
end

