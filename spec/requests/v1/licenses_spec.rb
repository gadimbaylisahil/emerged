require 'rails_helper'

describe 'License API', type: :request do
	
	describe '#GET v1/licenses' do
		it 'responds with list of licenses and status 200' do
			licenses = create_list(:license, 5)
			get '/v1/licenses'
			res = JSON.parse(response.body)
			expect(res["data"].count).to eq(licenses.count)
			expect(response.status).to eq(200)
		end
	end
	
	describe '#GET v1/licenses/:id' do
		it 'responds with license and status 200' do
			license = create(:license)
			get "/v1/licenses/#{license.id}"
			res = JSON.parse(response.body)
			expect(res["data"]["type"]).to eq("licenses")
			expect(res["data"]["id"]).to eq(license.id)
			expect(response.status).to eq(200)
		end
	end
	
	describe '#GET v1/licenses/:id/creations' do
		it 'responds with creations and status 200' do
			license = create(:license)
			creations = create_list(:creation, 5, license: license)
			get "/v1/licenses/#{license.id}/creations"
			res = JSON.parse(response.body)
			expect(res["data"].count).to eq(creations.count)
			expect(response.status).to eq(200)
		end
	end
end
