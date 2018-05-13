class DiscoveryController < ApplicationController
  def creations
    @creations = Creation.all
    json_response(object: @creations)
  end

  def stories
    @stories = Story.all
    json_response(object: @stories)
  end
end
