FactoryBot.define do
  factory :story do
    category
    user
    title { Faker::Lorem.word }
    content { Faker::Lorem.paragraph }
    disable_comments false
    sensitive_content false
    published true
  end
end