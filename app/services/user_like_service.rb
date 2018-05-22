class UserLikeService
  def initialize(user)
    @user = user
  end

  def total_likes_for_creations
    @user.creations.inject(0) { |total, creation| total += creation.get_likes.size }
  end

  def total_likes_for_stories
    @user.stories.inject(0) { |total, story| total += story.get_likes.size }
  end

  def total_likes
    total_likes_for_creations + total_likes_for_stories
  end
end

