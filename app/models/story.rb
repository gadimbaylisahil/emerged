class Story < ApplicationRecord
  belongs_to :user
  has_one_attached :cover_photo

  acts_as_taggable
  acts_as_votable
end
