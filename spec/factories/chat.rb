FactoryBot.define do
  factory :chat do
    identifier { SecureRandom.hex }
    factory :chat_with_messages do
      transient do
        user false
        other_user false
      end

      after(:create) do |chat, evaluator|
        # Subscribe two passed users into chat
        create(:subscription, chat: chat, user: evaluator.user)
        create(:subscription, chat: chat, user: evaluator.other_user)

        create(:message, chat: chat, user: evaluator.user)
        create(:message, chat: chat, user: evaluator.other_user)
      end
    end
  end
end