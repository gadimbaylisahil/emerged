module V1
	class LicensesController < V1::ApplicationController
		
		def show
			license = find_license
			render json: LicenseSerializer.new(license).serialized_json, status: :ok
		end
		
		def index
			licenses = License.all
			render json: LicenseSerializer.new(licenses).serialized_json, status: :ok
		end
		
		private
		def find_license
			License.find_by!(id: params[:id])
		end
	end
end
