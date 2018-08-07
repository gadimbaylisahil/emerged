module V1
	class CategoryResource < JSONAPI::Resource
		# attribute :name
		
		has_many :creations
	end
end