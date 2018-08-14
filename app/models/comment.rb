class Comment < ApplicationRecord
  belongs_to :user
  
  # Commentable models should include cached_comments_count int field in their table
  belongs_to :commentable, polymorphic: true
  validates :commentable, presence: true
  
  validates :body, presence: true
end
