FactoryBot.define do
  factory :message do
    chat
    user
    content { Faker::Lorem.sentence }
  end
end