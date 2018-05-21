class PaymentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :amount_cents

  has_one :billing_address
  has_one :shipping_address
  belongs_to :support
  belongs_to :user
end
