FactoryBot.define do
  factory :creation do
    user
    category

    title       { Faker::Lorem.characters(10) }
    content     { Faker::Lorem.paragraph }
    description { Faker::Lorem.paragraph }

    sensitive_content false
    disable_comments false
    published true

    factory :creation_with_comments do
      transient do
        comments_count 5
        user
      end

      after(:create) do |creation, evaluator|
        create_list(:comment, evaluator.comments_count, commentable: creation, user: evaluator.user)
      end
    end
  end
end