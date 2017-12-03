class ArtistsController < ApplicationController
  before_action :find_artist, only: [:show]
  layout "artist"
  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def destoy
  end

  private

  def find_artist
    @artist = Artist.find(params[:id])
  end
end