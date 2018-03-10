class UsersController < Clearance::UsersController
  layout 'dashboard', only: %i[dashboard edit]
  before_action :require_login, only: %i[dashboard]

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def dashboard
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name)
  end

  def url_after_create
    dashboard_path
  end
end