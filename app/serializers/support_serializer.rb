class SupportSerializer
  include FastJsonapi::ObjectSerializer
  attributes :amount_cents

  belongs_to :supportable, polymorphic: true
  belongs_to :user
  has_many :payment
end
