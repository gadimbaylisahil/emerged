module V1
	class CommentResource < JSONAPI::Resource
		attribute :body
		
		has_one :user
		has_one :commentable, polymorphic: true
	end
end