module StoryHelper
  def story_cover_photo_url(story:)
    return image_path('image_placeholder') unless story.cover_photo.attached?
    image_path url_for(story.cover_photo)
  end

  def get_body_tag(action:, controller:)
    if action == 'show' && controller == 'stories'
      'blog-post'
    elsif action == 'show' && controller == 'users'
      'profile-page'
    elsif action == 'stories' && controller == 'discovery'
      'blog-posts'
    else
      ''
    end
  end
end

