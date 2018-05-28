FactoryBot.define do
  factory :support do
    association :supporter, factory: :user
    association :creator, factory: :user
    association :supportable, factory: :reward
    is_paid true
    amount_cents { Faker::Number.number(5) }
  end
end