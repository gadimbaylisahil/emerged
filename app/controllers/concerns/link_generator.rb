module LinkGenerator
	# Generates links for collection requests
	# Maintains extra parameters passed alongside with page number
	extend ActiveSupport::Concern
	def self_link(page_number)
		return request.url if !page_number
		request.url.gsub!(request.query_parameters.to_query, request.query_parameters.merge(page: page_number).to_query)
	end
	
	def next_link(page_number)
		return '...' unless page_number
		request.url.gsub!(request.query_parameters.to_query, request.query_parameters.merge(page: page_number).to_query)
	end
	
	def prev_link(page_number)
		return '...' unless page_number
		request.url.gsub!(request.query_parameters.to_query, request.query_parameters.merge(page: page_number).to_query)
	end
end