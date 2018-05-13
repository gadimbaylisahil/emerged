class V1::UsersController < ApplicationController
  include Notifiable
  include Trackable

  before_action :authenticate_with_token, only: %i[follow unfollow dashboard edit update]
  before_action :find_user, only: %i[edit update dashboard]
  before_action :set_follow_user, only: %i[follow unfollow]
  before_action :get_user, only: %i[show]
  after_action  :increment_visitors, only: %i[show]
  after_action  -> { create_activity(subject: subject_for_activity, user: current_user) }, only: %i[follow unfollow update]
  after_action -> { create_notification(subject: @other_user, actor_user: current_user, recipient_user: @other_user)}, only: %i[follow]

  def new
    @user = User.new
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      json_response(object: @user, status: :updated)
    else
      head(:unprocessible_entity)
    end
  end

  def dashboard; end

  def follow
    current_user.follow @other_user
  end

  def unfollow
    current_user.stop_following @other_user
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

  def subject_for_activity
    return @user unless ['follow', 'unfollow'].include?(action_name)
    @other_user
  end
end
