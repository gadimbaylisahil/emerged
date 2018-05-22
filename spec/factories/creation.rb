FactoryBot.define do
  factory :creation do
    user
    license
    category

    title       { Faker::Lorem.characters(10) }
    content     { Faker::Lorem.paragraph }
    description { Faker::Lorem.paragraph }

    sensitive_content false
    disable_comments false
    published true
  end
end