FactoryBot.define do
  factory :support do
    user
    association :supportable, factory: :reward
    amount_cents { Faker::Number.number(5) }
  end
end