class Creation < ApplicationRecord
  belongs_to :user

  has_many :categorizations
  has_many :categories, through: :categorizations
  # Alias for acts_as_taggable_on :tags you can pass options instead of default value :skills, :interests etc
  acts_as_taggable
  acts_as_votable
end
