class DiscoveryController < ApplicationController
  layout :set_layout

  def index
    @creations = Creation.all
    @stories = Story.all
  end

  private
  def set_layout
    'application'
  end
end
