class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  after_create :create_activities

  def resource
    commentable.user
  end

  private

  def create_activities
    Activity.create(
        subject: self.commentable,
        activity_type: 'comment',
        user: user,
        is_public: true
    )
  end
end
