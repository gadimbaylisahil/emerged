class Story < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :comments, as: :commentable
  has_one_attached :cover_photo

  acts_as_votable

  def increment_view_counter
    self.number_of_views += 1
    save
  end
end
