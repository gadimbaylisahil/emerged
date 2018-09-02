module V1
	class LikeResource < JSONAPI::Resource
		caching
		
		has_one :user
		has_one :creation

		filter :user_id, apply: ->(records, value, _options) {
			records.find_by(user_id: value)
		}
	end
end
