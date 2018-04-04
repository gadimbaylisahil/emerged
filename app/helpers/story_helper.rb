module StoryHelper
  def story_cover_photo_url(story)
    return image_path('image_placeholder') unless story.cover_photo.attached?
    image_path url_for(story.cover_photo)
  end
end
