module V1
  class FollowResource < JSONAPI::Resource
    has_one :user
    has_one :followable, polymorphic: true
  end
end