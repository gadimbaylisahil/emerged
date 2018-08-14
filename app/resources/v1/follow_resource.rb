module V1
  class FollowResource < JSONAPI::Resource
    attribute :followable_type
    attribute :followable_id
    has_one :user
  end
end