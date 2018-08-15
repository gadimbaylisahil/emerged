module V1
	class CategoryResource < JSONAPI::Resource
		attributes :name
		has_many :creations
		
		
	end
end