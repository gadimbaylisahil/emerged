module CreationHelper
  def creation_cover_photo_url(creation:)
    return image_path('image_placeholder') unless creation.cover_photo.attached?
    image_path url_for(creation.cover_photo)
  end
  def creation_like_class(creation:)
    'd-none' if current_user.liked? creation
  end
  def creation_unlike_class(creation:)
    'd-none' unless current_user.liked? creation
  end
end
