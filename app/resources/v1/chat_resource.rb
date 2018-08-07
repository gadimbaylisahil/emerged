module V1
	class ChatResource < JSONAPI::Resource
		attribute :identifier
		
		has_many :subscriptions
		has_many :users, through: :subscriptions, class_name: 'User'
		has_many :messages
	end
end