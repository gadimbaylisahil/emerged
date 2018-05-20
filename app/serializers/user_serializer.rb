class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name, :username,
             :company, :city, :country,
             :about_me, :title, :website_url,
             :email, :display_name, :number_of_visitors
  has_many :creations
  has_many :stories
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
end