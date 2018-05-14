class StorySerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :content, :number_of_views,
             :disable_comments, :sensitive_content,
             :created_at
  belongs_to :user
  belongs_to :category
  has_many :comments
end
