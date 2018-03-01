class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[show]


  #New and Create will only be available for Administrators as normal registrations routes are living in Devise.
  def new
  end

  def create
    @user = User.create(user_params)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'Your details has been updated'
    else
      flash[:error] = @user.errors.full_messages.first
      render :edit
    end
  end

  def destroy
    @user.delete
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :avatar, :about, :role, :profession, :title, :username)
  end
end