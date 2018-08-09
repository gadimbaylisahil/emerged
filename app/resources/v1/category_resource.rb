module V1
	class CategoryResource < JSONAPI::Resource
		attributes :name
		has_many :creations, foreign_key: 'category_id'
	end
end