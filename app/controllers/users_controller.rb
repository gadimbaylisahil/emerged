class UsersController < Clearance::UsersController
  include Notifications
  layout 'dashboard', only: %i[dashboard edit]

  before_action :require_login, only: %i[dashboard edit update]
  before_action :find_user, only: %i[edit update dashboard]

  def new
    @user = User.new
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = "You profile has been updated."
      render_notification(flash[:success], 'success')
    else
      flash[:error] = @user.errors.full_messages.first
      render_notification(flash[:error], 'danger')
    end
  end

  def dashboard; end

  private

  def user_params
    params.require(:user).permit(:email, :password, :title, :about_me, :company, :username, :first_name, :last_name, :city, :country)
  end

  def url_after_create
    dashboard_path
  end

  def find_user
    @user = current_user
  end
end