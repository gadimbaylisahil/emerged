require 'rails_helper'

describe 'Creations API', type: :request do
  let(:user)    { FactoryBot.create(:user_with_creations) }
  let(:headers) { login_user(user: user, password: '123456') }

  describe '#GET v1/users/:id/creations' do
    before do
      get "/users/#{user.id}/creations/"
    end
    
    it 'responds with creations belonging to user' do
      res = JSON.parse(response.body)
      expect(res["data"].count).to eq(user.creations.count)
    end

    it 'responds with http status 200' do
      expect(response.status).to eq(200)
    end
  end

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
	    resources = {
			    comments: {
					    fields: [:body]
			    }
	    }
      expect(response.body).to eq(CreationSerializer.new(user.creations.first, SerializationOption.run(resources)).serialized_json)
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

  describe '#PATCH/PUT v1/creation/:id' do
    let(:valid_creation_params) { get_json(resource: 'creation', filename: 'valid_params') }

    context 'when parameters are valid' do
      before do
        patch "/creations/#{user.creations.last.id}", params: valid_creation_params, headers: headers
      end

      it 'responds with http status 200' do
        expect(response.status).to eq(200)
      end
    end
  end

  describe '#DELETE v1/creation/:id' do
    let(:creations_count) { user.creations.count }
    before do
      delete "/creations/#{user.creations.last.id}", headers: headers
    end

    it 'deletes creation' do
      expect(user.creations.count).to eq(creations_count)
    end

    it 'responds with http status 204' do
      expect(response.status).to eq(204)
    end
  end

  describe '#POST v1/creations/:id/likes' do
    let(:creation) { FactoryBot.create(:creation) }

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

  describe '#DELETE v1/creations/:id/likes' do
    let(:creation) { FactoryBot.create(:creation) }

    before do
      creation.liked_by user
      delete "/creations/#{creation.id}/likes", headers: headers
    end

    it 'unlikes the creation' do
      expect(creation.get_likes.count).to eq(0)
    end

    it 'responds with http status 204' do
      expect(response.status).to eq(204)
    end
  end

  describe '#POST v1/creations/:id/comments' do
    let(:creation) { FactoryBot.create(:creation) }
    let(:valid_comment_params) { attributes_for(:comment) }

    before do
      post "/creations/#{creation.id}/comments", params: valid_comment_params, headers: headers
    end

    it 'creates a comment' do
      expect(creation.comments.count).to eq(1)
    end

    it 'responds with http status 201' do
      expect(response.status).to eq(201)
    end
  end

  describe '#DELETE v1/creations/:id/comments/:id' do
    let(:creation) { FactoryBot.create(:creation_with_comments, user: user) }
    let(:comments_count) { creation.comments.count }

    before do
      delete "/creations/#{creation.id}/comments/#{creation.comments.last.id}", headers: headers
    end

    it 'deletes comment' do
      expect(creation.comments.count).to eq(comments_count)
    end

    it 'responds with http status 204' do
      expect(response.status).to eq(204)
    end
  end
end