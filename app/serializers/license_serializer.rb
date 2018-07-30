class LicenseSerializer
	include FastJsonapi::ObjectSerializer
	attributes :name, :description, :shorthand
end