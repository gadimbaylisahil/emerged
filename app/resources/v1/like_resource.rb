module V1
	class LikeResource < JSONAPI::Resource
		caching
		
		has_one :user
		has_one :creation
	end
end
