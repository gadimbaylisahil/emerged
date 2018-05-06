module Trackable
  extend ActiveSupport::Concern
  PUBLIC_ACTIVITIES = %i[like publish follow comment]
  def create_activities(subject:, user:)
    Activity.create!(
        subject: subject,
        activity_type: action_name,
        user: user,
        is_public: PUBLIC_ACTIVITIES.include?(action_name.to_sym) ? true : false
    )
  end
end