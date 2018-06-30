class NotificationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :created_at, :activity_type
  belongs_to :recipient_user, class_name: 'User'
  belongs_to :actor_user, class_name: 'User'
  belongs_to :subject, polymorphic: true

  attribute :from do |notification|
    notification.actor_user.username
  end

  attribute :humanized_activity do |notification|
    case notification.activity_type
    when 'follow'
      'followed'
    when 'like'
      'liked'
    end
  end

  attribute :subject_name do |notification|
    notification.subject.class
  end

  def humanize_activity(activity)
    case activity
    when 'follow'
      'followed'
    when 'like'
      'liked'
    end
  end
end
