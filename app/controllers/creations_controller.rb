class CreationsController < ApplicationController
  before_action :find_creation, only: %i[edit update destroy]

  def index
    @creations = Creation.all
  end

  def new
    @creation = Creation.new
  end

  def create
    @creation = Creation.new(creation_params)
    @creation.save
  end

  def edit
  end

  def update
    if @creation.update(creation_params)
      render status: 200, text: 'all good'
    else
      render :edit
    end
  end

  def destroy
    @creation.delete
  end

  private

  def find_creation
    @creation = Creation.find(params[:id])
  end

  def creation_params
    params.require(:creation).permit(:user, :content, :tag_list)
  end
end
