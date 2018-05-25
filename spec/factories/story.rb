FactoryBot.define do
  factory :story do
    category
    user
    title { Faker::Lorem.characters(10) }
    content { Faker::Lorem.paragraph }
    disable_comments false
    sensitive_content false
    published true

    factory :story_with_comments do
      transient do
        comments_count 5
        user
      end

      after(:create) do |story, evaluator|
        create_list(:comment, evaluator.comments_count, commentable: story, user: evaluator.user)
      end
    end
  end
end