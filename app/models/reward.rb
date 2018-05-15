class Reward < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_one_attached :cover_photo
  has_many_attached :images
  accepts_nested_attributes_for :images_attachments, allow_destroy: true
  before_update :purge_blobs

  monetize :shipping_cost_cents
  monetize :price_cents

  store :variants


  private
  def purge_blobs
    images_attachments.each do |attachment|
      if attachment.marked_for_destruction?
        attachment.blob.purge_later
      end
    end
  end
end
