FactoryBot.define do
  factory :license do
    name        { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
  end
end