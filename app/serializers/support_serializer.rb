class SupportSerializer
  include FastJsonapi::ObjectSerializer
  attributes :amount_cents

  belongs_to :supportable, polymorphic: true
  belongs_to :supporter, class_name: 'User'
  belongs_to :creator, class_name: 'User'
  has_one :payment
end
