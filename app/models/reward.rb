class Reward < ApplicationRecord
  belongs_to :user

  has_one_attached :cover_photo
  has_many_attached :images
  accepts_nested_attributes_for :images_attachments, allow_destroy: true
  before_update :purge_blobs

  monetize :tier_price_cents

  private
  def purge_blobs
    images_attachments.each do |attachment|
      if attachment.marked_for_destruction?
        attachment.blob.purge_later
      end
    end
  end
end
