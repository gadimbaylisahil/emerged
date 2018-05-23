FactoryBot.define do
  factory :comment do
    user
    body { Faker::Lorem.sentence }
    association :commentable, factory: :creation
  end
end