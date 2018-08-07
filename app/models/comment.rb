class Comment < ApplicationRecord
  belongs_to :user
  
  # Commentable models should include cached_comments_count int field in their table
  belongs_to :commentable, polymorphic: true

  validates :body, presence: true
  
  after_create :increment_cache_comments_count
  after_destroy :decrement_cache_comments_count
  
  private
  
  def increment_cache_comments_count
    commentable.cached_comments_count += 1
    commentable.save!
  end
  
  def decrement_cache_comments_count
    commentable.cached_comments_count -= 1
    commentable.save!
  end
end
