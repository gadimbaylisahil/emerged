FactoryBot.define do
  factory :reward do
    user
    amount_cents { Faker::Number.number(5) }
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    content { Faker::Lorem.paragraph }
  end
end