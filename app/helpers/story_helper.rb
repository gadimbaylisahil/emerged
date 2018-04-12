module StoryHelper
  def story_cover_photo_url(story)
    return image_path('image_placeholder') unless story.cover_photo.attached?
    image_path url_for(story.cover_photo)
  end

  def get_body_tag(action:, controller:)
    'blog-post' if action == 'show' && controller == 'stories'
  end
end
