class CartSerializer
  include FastJsonapi::ObjectSerializer
  attributes :total_cents, :status

  has_many :cart_items
  has_many :rewards, through: :cart_items
  belongs_to :user
end
