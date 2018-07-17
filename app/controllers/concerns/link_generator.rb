module LinkGenerator
	# Generates links for collection requests
	# Maintains extra parameters passed alongside with page number
	extend ActiveSupport::Concern
	def self_link(page_number)
		return request.url unless page_number.present?
		request_query = request.url.split('?')
		request_query[1] = request.query_parameters.merge(page: page_number).to_query
		request_query.join('?')
	end
	
	def next_link(page_number)
		return nil unless page_number.present?
		request_query = request.url.split('?')
		request_query[1] = request.query_parameters.merge(page: page_number).to_query
		request_query.join('?')
	end
	
	def prev_link(page_number)
		return nil unless page_number.present?
		request_query = request.url.split('?')
		request_query[1] = request.query_parameters.merge(page: page_number).to_query
		request_query.join('?')
	end
end