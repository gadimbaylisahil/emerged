class RewardSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description, :content, :amount
  belongs_to :user
end
