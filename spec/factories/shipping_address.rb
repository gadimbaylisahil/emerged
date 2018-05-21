FactoryBot.define do
  factory :shipping_address do
    payment

    street { Faker::Address.street_address }
    street_optional { Faker::Address.secondary_address }
    city { Faker::Address.city }
    postal_code { Faker::Address.postcode }
    country { Faker::Address.country }

    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    company { Faker::Company.name }
  end
end