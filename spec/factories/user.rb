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
    title        { Faker::Name.title }
    email        { Faker::Internet.unique.email }
    username     { Faker::Name.name }

    password   '123456'
    password_confirmation '123456'
  end
end