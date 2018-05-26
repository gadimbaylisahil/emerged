require 'rails_helper'
describe 'User API', type: :request do
  describe '#GET /users' do
    let!(:users) { FactoryBot.create_list(:user, 5) }
    before do
      get '/users'
    end

    it 'responds with users' do
      expect(response.body).to eq(UserSerializer.new(users).serialized_json)
    end

    it 'responds with http status 200' do
      expect(response.status).to eq(200)
    end
  end

  describe '#GET /users/:id' do
    let!(:user) { FactoryBot.create(:user) }
    before do
      get "/users/#{user.id}"
    end

    it 'responds with user' do
      expect(response.body).to eq(UserSerializer.new(user).serialized_json)
    end

    it 'responds with http status 200' do
      expect(response.status).to eq(200)
    end
  end

  describe '#PATCH/PUT /users/:id' do
    let!(:user) { FactoryBot.create(:user) }
    let(:valid_credentials) { { "email": user.email, password: "123456"} }

    before do
      post '/sessions', params: valid_credentials
    end

    let(:valid_jwt_token) { JSON.parse(response.body)["token"] }
    let(:headers)         { { "Authorization": "Bearer #{valid_jwt_token}" } }


    context 'when params are valid' do
      let(:user_params) { get_json(resource: 'user', filename: 'valid_params') }
      before do
        patch "/users/#{user.id}", params: user_params, headers: headers
      end

      it 'responds with http status 200' do
        expect(response.status).to eq(200)
      end
    end
  end
end