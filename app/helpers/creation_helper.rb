module CreationHelper
  def creation_cover_photo_url(creation)
    return image_path('image_placeholder') unless creation.cover_photo.attached?
    image_path url_for(creation.cover_photo)
  end
end