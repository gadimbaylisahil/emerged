module V1
	class SubscriptionResource < JSONAPI::Resource
		has_one :user
		has_one :chat
	end
end