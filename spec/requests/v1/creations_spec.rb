require 'rails_helper'

describe 'Creations API', type: :request do
  let(:user)              { FactoryBot.create(:user_with_creations) }
  let(:valid_credentials) { { "email": user.email, password: "123456"} }

  before do
    post '/sessions', params: valid_credentials
  end

  let(:valid_jwt_token) { JSON.parse(response.body)["token"] }
  let(:headers)         { { "Authorization": "Bearer #{valid_jwt_token}" } }

  describe '#GET v1/creations' do
    before do
      get '/creations', headers: headers
    end

    it 'responds with users creations' do
      res = JSON.parse(response.body)
      expect(res["data"].count).to eq(user.creations.count)
    end

    it 'responds with http status 200' do
      expect(response.status).to eq(200)
    end
  end

  describe '#GET v1/creations/:id' do
    before do
      get "/creations/#{user.creations.first.id}", headers: headers
    end

    it 'responds with creation' do
      expect(response.body).to eq(CreationSerializer.new(user.creations.first,
                                                         include_resources(%w[comments])).serialized_json)
    end

    it 'responds with http status 200' do
      expect(response.status).to eq(200)
    end
  end

  describe '#POST v1/creations' do
    let(:valid_creation_params) { attributes_for(:creation) }
    let(:invalid_creation_params) { get_json(resource: 'creation', file_name: 'invalid_params') }

    context 'when parameters are valid' do
      before do
        post '/creations', params: valid_creation_params, headers: headers
      end

      it 'creates and response with creation' do
        expect(response.body).to eq(CreationSerializer.new(user.creations.last).serialized_json)
      end

      it 'responds with http status 201' do
        expect(response.status).to eq(201)
      end
    end
  end

  describe '#POST v1/creations/:id/likes' do
    let(:creation) { FactoryBot.create(:creation) }

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
    let(:creation) { FactoryBot.create(:creation) }

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