FactoryBot.define do
  factory :chat do
    identifier { SecureRandom.hex }
  end
end