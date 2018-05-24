require 'rails_helper'
describe 'Sessions API', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:valid_credentials) { { "email": user.email, password: "123456"} }
  let(:invalid_password)  { { "email": user.email, password: "wrongpassword"} }
  let(:invalid_email)     { get_json(resource: 'user', filename: 'invalid_credentials') }
  describe '#POST v1/sessions' do

    context 'when credentials are valid' do
      before do
        post '/sessions', params: valid_credentials
      end

      it 'responds with users data' do
        res = JSON.parse(response.body)
        expect(res['data']['type']).to eq('user')
      end

      it 'returns JWT token' do
        res = JSON.parse(response.body)
        expect(res["token"]).to_not be_nil
      end

      it 'responds with http status 201' do
        expect(response.status).to eq(201)
      end
    end

    context 'when email is invalid' do
      before do
        post '/sessions', params: invalid_email
      end

      it 'responds with http status 404' do
        expect(response.status).to eq(404)
      end
    end

    context 'when password is invalid' do
      before do
        post '/sessions', params: invalid_password
      end

      it 'responds with http status 404' do
        expect(response.status).to eq(401)
      end
    end
  end

  describe '#DELETE v1/sessions' do
    before do
      post '/sessions', params: valid_credentials
    end

    context 'after logging out' do
      let(:valid_jwt_token) { JSON.parse(response.body)["token"] }

      before do
        delete '/sessions', headers: { "Authorization": "Bearer #{valid_jwt_token}" }
      end

      it 'responds with http status 204' do
        expect(response.status).to eq(204)
      end
    end
  end
end