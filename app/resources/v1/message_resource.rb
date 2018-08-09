module V1
	class MessageResource < JSONAPI::Resource
		attribute :content
		has_one :chat
	end
end