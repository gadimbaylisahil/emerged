class CreationsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create destroy edit update]
  before_action :find_creation, only: %i[show edit update destroy]

  def index
    @creations = Creation.all
  end

  def show
  end

  def new
    @creation = current_user.creations.new
  end

  def create
    if @creation = current_user.create_creation(creation_params)
      flash[:success] = 'New creation has been created!'
    else
      flash[:error] = @creation.errors.full_messages.first
      render :new
    end
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
