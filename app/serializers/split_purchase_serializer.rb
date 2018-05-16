class SplitPurchaseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :total_cents, :fullfillment_status

  belongs_to :user
  belongs_to :purchase
  has_many :cart_items
end