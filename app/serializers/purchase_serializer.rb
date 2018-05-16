class PurchaseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :total_cents, :status, :fullfillment_status

  belongs_to :user
  belongs_to :cart
  has_many :cart_items
  has_many :split_purchases
end
