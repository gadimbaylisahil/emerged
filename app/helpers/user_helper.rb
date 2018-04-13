module UserHelper
  def avatar_url(user:)
    return image_path('image_placeholder') unless user.avatar.attached?
    image_path url_for(user.avatar)
  end

  def user_cover_photo_url(user:)
    return image_path('cover_photo') unless user.cover_photo.attached?
    image_path url_for(user.cover_photo)
  end
end
