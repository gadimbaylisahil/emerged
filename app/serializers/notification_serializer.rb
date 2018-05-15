class NotificationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :created_at
  belongs_to :recipient_user, class_name: 'User'
  belongs_to :actor_user, class_name: 'User'
  belongs_to :subject, polymorphic: true
end
