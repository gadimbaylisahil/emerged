module V1
  class RewardResource < JSONAPI::Resource
    attribute :title
    attribute :description
    attribute :amount_cents
    attribute :require_shipping
    attribute :content

    has_one :user

    before_save do
      @model.user_id = context[:current_user].id if @model.new_record?
    end
  end
end