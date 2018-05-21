class ProjectSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description, :content

  belongs_to :user
  belongs_to :category
  has_many :supports, as: :supportable
  has_many :comments, as: :commentable
end
