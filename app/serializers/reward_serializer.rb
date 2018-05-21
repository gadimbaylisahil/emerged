class RewardSerializer
  include FastJsonapi::ObjectSerializer
  attributes # TODO: fill in with attributes
  belongs_to :user
end
