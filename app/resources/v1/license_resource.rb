module V1
	class LicenseResource < JSONAPI::Resource
		attribute :name
		
		has_many :creations
	end
end