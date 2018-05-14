class CreationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :content, :description, :title,
             :license, :number_of_views, :published?,
             :license_id, :sensitive_content,
             :disable_comments, :created_at
  belongs_to :user
  belongs_to :category
end