class SupportSerializer
  include FastJsonapi::ObjectSerializer
  attributes :amount_cents
  # TODO: find a way to serialize polymorphic resources
  belongs_to :supportable, polymorphic: true
  belongs_to :supporter, class_name: 'User', serializer: :user
  belongs_to :creator, class_name: 'User', serializer: :user
  has_one :payment
end
