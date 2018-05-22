FactoryBot.define do
  factory :notification do
    association :recipient_user, factory: :user
    association :actor_user, factory: :user
    association :subject, factory: :creation
    activity_type 'like'
  end
end