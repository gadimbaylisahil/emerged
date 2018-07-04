class CommentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :body

  belongs_to :user
  belongs_to :commentable, polymorphic: true
  
  attribute :username do |comment|
    comment.user.username
  end
end
