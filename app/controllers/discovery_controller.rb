class DiscoveryController < ApplicationController
  layout :set_layout

  def creations
    @creations = Creation.all
  end

  def stories
    @stories = Story.all
  end

  private

  def set_layout
    'application'
  end
end
