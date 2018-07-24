class SerializationOption
	def initialize(resources, links)
		@resources = resources
		@links = links
		@options = {}
	end
	
	def self.run(resources = {}, links = {} )
		new(resources, links).run
	end
	
	def run
		include_resources
		limit_included_resource_fields
		include_links
		@options
	end
	
	private
	
	def include_resources
		return unless @resources.present?
		@options[:include] = []
		@resources.each_key do |key|
			@options[:include].push(key)
		end
	end
	
	def limit_included_resource_fields
		return unless @resources.present?
		@options[:fields] = {}
		@resources.each do |key, value|
			next unless value[:fields].any?
			@options[:fields].merge!(key.to_s.singularize.to_sym => value[:fields])
		end
	end
	
	def include_links
		return unless @links.present?
		@options[:links]=
				{
						self: @links[:self],
						next: @links[:next],
						prev: @links[:prev]
				}
	end
end