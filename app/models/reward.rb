class Reward < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :comments, as: :commentable
  has_one_attached :cover_photo
  has_many_attached :images
  monetize :shipping_cost_cents
  monetize :price_cents
end
