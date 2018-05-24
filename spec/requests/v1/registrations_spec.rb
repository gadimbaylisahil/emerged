require 'rails_helper'
describe 'Registrations API', type: :request do
  describe '#Post v1/registrations' do
    let(:basic_valid_user_parameters) {
      {
          'first_name': Faker::Name.first_name,
          'last_name': Faker::Name.last_name,
          'email': Faker::Internet.unique.email,
          'username': Faker::Internet.user_name(10),
          'password': '123456',
          'password_confirmation': '123456'
      }
    }

    let(:invalid_parameters) {
    }

    context 'when parameters are valid' do
      before do
        post '/registrations', params: basic_valid_user_parameters
      end

      it 'registers a new user' do
        expect(User.count).to eq(1)
      end

      it 'reponds with new users data' do
        res = JSON.parse(response.body)
        expect(res["data"]["type"]).to eq("user")
      end

      it 'returns JWT token' do
        res = JSON.parse(response.body)
        expect(res["token"]).to_not be_nil
      end

      it 'responds with http status 201' do
        expect(response.status).to eq(201)
      end
    end

    context 'when parameters are invalid' do
      before do
        post '/registrations', params: invalid_parameters
      end

      it 'responds with http status 422' do
        expect(response.status).to eq(422)
      end
    end
  end
end