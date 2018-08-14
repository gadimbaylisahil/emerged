FactoryBot.define do
  factory :follow do
    user
    association :followable, factory: :user
  end
end