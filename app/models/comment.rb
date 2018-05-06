class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  after_create :create_activity
  after_create :create_notification

  def resource
    commentable.user
  end

  private

  def create_activity
    Activity.create(
        subject: commentable,
        activity_type: 'comment',
        user: user,
        is_public: true
    )
  end
  def create_notification
    Notification.create(
        actor_user: user,
        recipient_user: commentable.user,
        activity_type: 'comment',
        subject: self.commentable
    )
  end
end
