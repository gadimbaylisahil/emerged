class CreationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :content, :description, :title,
             :license, :number_of_views, :published,
             :license_id, :sensitive_content,
             :disable_comments, :created_at

  attribute :total_likes do |creation|
    creation.get_likes.count
  end

  belongs_to :user
  belongs_to :category
  has_many   :comments, as: :commentable
end