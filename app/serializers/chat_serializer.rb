class ChatSerializer
  include FastJsonapi::ObjectSerializer
  attributes :identifier

  has_many :messages, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions
end
