class Reward < ApplicationRecord
  belongs_to :user
  has_many :supports, as: :supportable

  has_one_attached :cover_photo
  has_many_attached :images

  validates :title, presence: true, length: { minimum: 4 }
  validates :description, presence: true
  validates :content, presence: true
  validates :amount_cents, presence: true, numericality: true

  monetize :amount_cents
end
