class RewardSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description, :content, :cover_photo, :tier_price
  belongs_to :user
end
