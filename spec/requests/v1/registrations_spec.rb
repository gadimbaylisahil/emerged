require 'rails_helper'
describe 'Registrations API', type: :request do
  describe '#Post v1/registrations' do
    context 'when parameters are valid' do

      it 'registers user, responds with user and status 201' do
	      valid_user_params = get_json(resource: 'user', filename: 'valid_registration_params')
	      post '/v1/registrations', params: valid_user_params
	      expect(User.count).to eq(1)
        res = JSON.parse(response.body)
        expect(res["data"]["type"]).to eq("users")
	      expect(response.status).to eq(201)
      end

      it 'responds with jwt token' do
        valid_user_params = get_json(resource: 'user', filename: 'valid_registration_params')
        post '/v1/registrations', params: valid_user_params
        res = JSON.parse(response.body)
        expect(res["token"]).to_not be_nil
      end
    end
	  
  end
end