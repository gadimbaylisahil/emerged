class ActivityService
  def initialize(user)
    @user = user
  end

  def recent_activities(limit)
    @user.activities.order('created_at DESC').limit(limit)
  end

  def recent_public_activities(limit)
    @user.activities.where(is_public: true).order('created_at DESC').limit(limit)
  end
end