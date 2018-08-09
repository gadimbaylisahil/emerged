FactoryBot.define do
  factory :user do
    first_name   { Faker::Name.first_name }
    last_name    { Faker::Name.last_name }
    about_me     { Faker::Lorem.paragraph }
    company      { Faker::Company.name }
    city         { Faker::Address.city }
    country      { Faker::Address.country }
    website_url  { Faker::Internet.url('example.com') }
    display_name { Faker::Name.name }
    title        { Faker::Job.title }
    email        { Faker::Internet.unique.email }
    username     { Faker::Name.name }

    password   '123456'
    password_confirmation '123456'

    factory :user_with_creations do
      transient do
        creations_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:creation, evaluator.creations_count, user: user)
      end
    end
    

    factory :user_with_rewards do
      transient do
        rewards_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:reward, evaluator.rewards_count, user: user)
      end
    end
  end
end