module RewardsHelper
  def reward_cover_photo_url(reward:)
    return image_path('image_placeholder') unless reward.cover_photo.attached?
    image_path url_for(reward.cover_photo)
  end
end