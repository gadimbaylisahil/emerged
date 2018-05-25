require 'rails_helper'

describe 'Creations API', type: :request do
  let(:user)              { FactoryBot.create(:user) }
  let(:valid_credentials) { { "email": user.email, password: "123456"} }

  before do
    post '/sessions', params: valid_credentials
  end

  let(:valid_jwt_token) { JSON.parse(response.body)["token"] }
  let(:headers)         { { "Authorization": "Bearer #{valid_jwt_token}" } }
  let(:creation)        { FactoryBot.create(:creation) }

  describe '#POST v1/creations' do

  end

  describe '#POST v1/creations/:id/likes' do
    context 'when liking creation' do
      before do
        post "/creations/#{creation.id}/likes", headers: headers
      end

      it 'likes creation' do
        expect(creation.get_likes.count).to eq(1)
      end

      it 'responds with http status 201' do
        expect(response.status).to eq(201)
      end
    end
  end

  describe '#DELETE v1/creations/:id/likes' do
    before do
      creation.liked_by user
    end

    context 'when unliking creation' do
      before do
        delete "/creations/#{creation.id}/likes", headers: headers
      end

      it 'unlikes the creation' do
        expect(creation.get_likes.count).to eq(0)
      end

      it 'responds with http status 204' do
        expect(response.status).to eq(204)
      end
    end
  end
end