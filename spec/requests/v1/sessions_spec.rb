require 'rails_helper'
describe 'Sessions API', type: :request do
  describe '#POST v1/sessions' do
    context 'when credentials are valid' do
      it 'responds with user data and status 200' do
	      user = create(:user)
	      valid_credentials = {
			      "email": user.email,
			      "password": "123456"
	      }
	      post '/v1/sessions', params: valid_credentials
	      res = JSON.parse(response.body)
	      expect(res["data"]["type"]).to eq("users")
	      expect(response.status).to eq(200)
      end
      
      it 'responds with jwt token' do
        user = create(:user)
        valid_credentials = {
            "email": user.email,
            "password": "123456"
        }
        post '/v1/sessions', params: valid_credentials
        res = JSON.parse(response.body)
        expect(res["token"]).to_not be_nil
      end
    end
  end

  describe '#DELETE v1/sessions' do
	  
	  it 'responds with http status 204' do
		  user = create(:user)
		  post '/v1/sessions', params: { "email": user.email, "password": "123456"}
		  res = JSON.parse(response.body)
		  valid_jwt_token = res["token"]
		  delete '/v1/sessions', headers: { "Authorization": "Bearer #{valid_jwt_token}" }
		  expect(response.status).to eq(204)
	  end
	  
  end
end