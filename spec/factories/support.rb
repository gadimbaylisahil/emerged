FactoryBot.define do
  factory :support do
    association :supporter, factory: :user
    association :creator, factory: :user
    association :supportable, factory: :reward
    amount_cents { Faker::Number.number(5) }
  end
end