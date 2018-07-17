class CreationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :content, :description, :title,
             :published, :impressions_count,
             :license_id, :sensitive_content,
             :disable_comments, :created_at

  link :self do |creation|
    "http://localhost:8081/creations/#{creation.id}"
  end
  
  attribute :total_likes do |creation|
    creation.get_likes.count
  end

  attribute :total_comments do |creation|
    creation.comments.count
  end

  attribute :username do |creation|
    creation.user.username
  end

  attribute :liker_ids do |creation|
    creation.votes_for.up.voters.pluck(:id)
  end

  belongs_to :user
  belongs_to :category
  has_many   :comments, as: :commentable
end