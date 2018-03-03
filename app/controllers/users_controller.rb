class UsersController < Clearance::UsersController
  def new
    @user = User.new
  end

  def create
    @user = user_from_params

    if @user.save
      sign_in @user
      redirect_to root_path
    else
      render template: "users/new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name)
  end
end