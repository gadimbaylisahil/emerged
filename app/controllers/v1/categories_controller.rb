module V1
	class CategoriesController < V1::ApplicationController
		before_action :authenticate_with_token, only: %i[subscribe unsubscribe]
		
		def subscribe
			category = find_category
			current_user.follow category
			head(:ok)
		end
		
		def unsubscribe
			category = find_category
			current_user.stop_following category
			head(:no_content)
		end
		
		private
		
		def find_category
			Category.find_by!(id: params[:id])
		end
	end
end
