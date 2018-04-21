class Creation < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :comments, as: :commentable
  has_one_attached :cover_photo

  # Alias for acts_as_taggable_on :tags you can pass options instead of default value :skills, :interests etc
  acts_as_taggable
  acts_as_votable

  validates :content, presence: true
  validates :title,
            length: { within: 6..50, message: 'must be between 10 to 50 characters.' }

  def increment_view_counter
    self.number_of_views += 1
    save
  end
end
