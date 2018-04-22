class UsersController < Clearance::UsersController
  include Notifications
  layout :set_layout

  before_action :require_login, only: %i[follow unfollow dashboard edit update]
  before_action :find_user, only: %i[edit update dashboard]
  before_action :set_follow_user, only: %i[follow unfollow]
  before_action :get_user, only: %i[show]
  after_action  :increment_visitors, only: %i[show]
  def new
    @user = User.new
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = 'You profile has been updated.'
      render_notification(flash[:success], 'success')
    else
      flash[:error] = @user.errors.full_messages.first
      render_notification(flash[:error], 'danger')
    end
  end

  def dashboard; end

  def follow
    current_user.follow @other_user
    respond_to do |format|
      format.js
    end
  end

  def unfollow
    current_user.stop_following @other_user
    respond_to do |format|
      format.js
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :avatar, :cover_photo, :password, :title, :about_me, :company, :username, :first_name, :last_name, :city, :country, :website, :display_name)
  end

  def url_after_create
    dashboard_path
  end

  def find_user
    @user = current_user
  end

  def get_user
    @user = User.find(params[:user_id] || params[:id])
  end

  def set_follow_user
    @other_user = User.find(params[:id])
  end

  def increment_visitors
    @user.increment_visitors
  end

  def set_layout
    case action_name
      when 'dashboard', 'edit'
        'dashboard'
      when 'new'
        'session_and_registration'
      when 'show'
        'application'
    end
  end
end
