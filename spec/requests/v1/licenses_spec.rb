require 'rails_helper'

describe 'License API', type: :request do
	
	describe '#GET v1/licenses' do
		let!(:license)       { FactoryBot.create(:license) }
		
		before do
			get "/licenses"
		end
		
		it 'responds with list of current licenses' do
			expect(response.body).to eq(LicenseSerializer.new(License.all).serialized_json)
		end
		
		it 'responds with http status 200' do
			expect(response.status).to eq(200)
		end
	end
	
	describe '#GET v1/licenses/:id' do
		let!(:license)       { FactoryBot.create(:license) }
		
		before do
			get "/licenses/#{license.id}", headers: headers
		end
		
		it 'responds with license' do
			expect(response.body).to eq(LicenseSerializer.new(license).serialized_json)
		end
		
		it 'responds with http status 200' do
			expect(response.status).to eq(200)
		end
	end
end
