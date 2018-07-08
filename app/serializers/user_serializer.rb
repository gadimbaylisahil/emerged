class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name, :username,
             :company, :city, :country,
             :about_me, :title, :website_url,
             :email, :display_name, :number_of_visitors

  link :profile_url do |user|
    "http://localhost:8080/users/#{user.id}"
  end
  
  has_many :given_supports, class_name: 'Support', foreign_key: :supporter_id
  has_many :received_supports, class_name: 'Support', foreign_key: :creator_id
  has_many :creations
  has_many :rewards
  has_many :notifications, foreign_key: :recipient_user_id
  has_many :messages
  has_many :subscriptions
  has_many :chats, through: :subscriptions
  has_many :comments
  has_many :activities

#   Custom attributes
#   attribute :name_with_year do |object|
#     "#{object.name} (#{object.year})"
#   end
  attribute :following_ids do |user|
    user.all_following.pluck(:id)
  end
end
