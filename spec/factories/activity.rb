FactoryBot.define do
  factory :activity do
    user
    association :subject, factory: :creation
    activity_type 'Like'
    is_public true
  end
end