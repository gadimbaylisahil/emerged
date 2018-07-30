FactoryBot.define do
  factory :license do
    name        { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
    shorthand   { Faker::Lorem.word }
  end
end