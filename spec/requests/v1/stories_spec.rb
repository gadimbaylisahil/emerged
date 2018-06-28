require 'rails_helper'

describe 'Story API', type: :request do
  let(:user)    { FactoryBot.create(:user_with_stories) }
  let(:headers) { login_user(user: user, password: '123456') }

  describe '#GET v1/stories/discover' do
    before do
      get '/stories/discover'
    end

    it 'responds with users stories' do
      res = JSON.parse(response.body)
      expect(res["data"].count).to eq(Story.all.count)
    end

    it 'responds with http status 200' do
      expect(response.status).to eq(200)
    end
  end

  describe '#GET v1/stories' do
    before do
      get '/stories', headers: headers
    end

    it 'responds with users stories' do
      res = JSON.parse(response.body)
      expect(res["data"].count).to eq(user.stories.count)
    end

    it 'responds with http status 200' do
      expect(response.status).to eq(200)
    end
  end

  describe '#GET v1/stories/:id' do
    before do
      get "/stories/#{user.stories.first.id}", headers: headers
    end

    it 'responds with story' do
      expect(response.body).to eq(StorySerializer.new(user.stories.first,
                                                      include_resources(%w[comments])).serialized_json)
    end

    it 'responds with http status 200' do
      expect(response.status).to eq(200)
    end
  end

  describe '#POST v1/stories' do
    let(:valid_story_params) { attributes_for(:story) }
    let(:invalid_story_params) { get_json(resource: 'story', file_name: 'invalid_params') }

    context 'when parameters are valid' do
      before do
        post '/stories', params: valid_story_params, headers: headers
      end

      it 'creates and responds with story' do
        expect(response.body).to eq(StorySerializer.new(user.stories.last).serialized_json)
      end

      it 'responds with http status 201' do
        expect(response.status).to eq(201)
      end
    end
  end

  describe '#PATCH/PUT v1/story/:id' do
    let(:valid_story_params) { get_json(resource: 'story', filename: 'valid_params') }

    context 'when parameters are valid' do
      before do
        patch "/stories/#{user.stories.last.id}", params: valid_story_params, headers: headers
      end

      it 'responds with http status 200' do
        expect(response.status).to eq(200)
      end
    end
  end

  describe '#DELETE v1/story/:id' do
    let(:stories_count) { user.stories.count }
    before do
      delete "/stories/#{user.stories.last.id}", headers: headers
    end

    it 'deletes story' do
      expect(user.stories.count).to eq(stories_count)
    end

    it 'responds with http status 204' do
      expect(response.status).to eq(204)
    end
  end

  describe '#POST v1/stories/:id/likes' do
    let(:story) { FactoryBot.create(:story) }

    before do
      post "/stories/#{story.id}/likes", headers: headers
    end

    it 'likes story' do
      expect(story.get_likes.count).to eq(1)
    end

    it 'responds with http status 201' do
      expect(response.status).to eq(201)
    end
  end

  describe '#DELETE v1/stories/:id/likes' do
    let(:story) { FactoryBot.create(:story) }

    before do
      story.liked_by user
      delete "/stories/#{story.id}/likes", headers: headers
    end

    it 'unlikes the story' do
      expect(story.get_likes.count).to eq(0)
    end

    it 'responds with http status 204' do
      expect(response.status).to eq(204)
    end
  end

  describe '#POST v1/stories/:id/comments' do
    let(:story) { FactoryBot.create(:story) }
    let(:valid_comment_params) { attributes_for(:comment) }

    before do
      post "/stories/#{story.id}/comments", params: valid_comment_params, headers: headers
    end

    it 'creates a comment' do
      expect(story.comments.count).to eq(1)
    end

    it 'responds with http status 201' do
      expect(response.status).to eq(201)
    end
  end

  describe '#DELETE v1/stories/:id/comments/:id' do
    let(:story) { FactoryBot.create(:story_with_comments, user: user) }
    let(:comments_count) { story.comments.count }

    before do
      delete "/stories/#{story.id}/comments/#{story.comments.last.id}", headers: headers
    end

    it 'deletes comment' do
      expect(story.comments.count).to eq(comments_count)
    end

    it 'responds with http status 204' do
      expect(response.status).to eq(204)
    end
  end
end