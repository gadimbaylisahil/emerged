class Project < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :supports, as: :supportable
  has_many :comments, as: :commentable
end
