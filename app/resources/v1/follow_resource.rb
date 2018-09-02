module V1
  class FollowResource < JSONAPI::Resource
    attribute :followable_type
    attribute :followable_id
    has_one :user

    filter :user_id, apply: ->(records, value, _options) {
      records.find_by(user_id: value)
    }
  end
end