FactoryBot.define do
  factory :notification do
    recipient_user_id 1
    actor_user_id 1
    read_at "2018-05-06 21:45:48"
    activity_type "MyString"
    subject_id 1
    subject_type "MyString"
  end
end
