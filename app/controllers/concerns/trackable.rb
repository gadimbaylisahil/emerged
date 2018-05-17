module Trackable
  extend ActiveSupport::Concern
  PUBLIC_ACTIVITIES = %w[like follow comment]
  def create_activity(subject:, user:, activity_type:)
    Activity.create!(
        subject: subject,
        activity_type: activity_type,
        user: user,
        is_public: PUBLIC_ACTIVITIES.include?(activity_type) ? true : false
    )
  end
end