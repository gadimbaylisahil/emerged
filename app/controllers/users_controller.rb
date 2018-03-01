class UsersController < ApplicationController
  def edit
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :avatar, :about, :role, :profession, :title, :username)
  end
end