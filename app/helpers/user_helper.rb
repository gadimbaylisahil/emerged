module UserHelper
  def avatar_url
    return image_path('image_placeholder') unless current_user.avatar.attached?
    image_path url_for(current_user.avatar)
  end

  def cover_photo_url
    return image_path('cover_photo') unless current_user.cover_photo.attached?
    image_path url_for(current_user.cover_photo)
  end
end
