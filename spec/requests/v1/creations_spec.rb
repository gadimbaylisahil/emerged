require 'rails_helper'

describe 'Creations API', type: :request do
  # let(:user)    { FactoryBot.create(:user_with_creations) }
  # let(:headers) { login_user(user: user, password: '123456') }

  describe '#GET v1/creations' do
    it 'responds with creations and status 200' do
	    FactoryBot.create(:creation)
	    get '/v1/creations'
      res = JSON.parse(response.body)
      expect(res["data"].count).to eq(Creation.count)
	    expect(response.status).to eq(200)
    end
  end

  describe '#GET v1/creations/:id' do
    it 'responds with creation and status 200' do
	    creation = FactoryBot.create(:creation)
	    get "/v1/creations/#{creation.id}"
	    res = JSON.parse(response.body)
	    expect(res["data"]["type"]).to eq("creations")
	    expect(res["data"]["id"]).to eq(creation.id)
	    expect(response.status).to eq(200)
    end
  end
  
  describe '#POST v1/creations' do
	  context 'when parameters are valid' do
      it 'creates and responds  with creation and status 201' do
	      license = FactoryBot.create(:license)
	      category = FactoryBot.create(:category)
	      user = FactoryBot.create(:user)
	      valid_params = get_json(resource: "creation", filename: "valid_params")
	      valid_params["data"]["relationships"]["category"]["data"]["id"] = category.id.to_s
	      valid_params["data"]["relationships"]["license"]["data"]["id"] = license.id.to_s
	      header = login_user(user: user, password: '123456')
	      post "/v1/creations", params: valid_params.to_json, headers: header
	      res = JSON.parse(response.body)
	      expect(res["data"]["attributes"]["title"]).to eq(valid_params["data"]["attributes"]["title"])
	      expect(response.status).to eq(201)
      end
    end
  end
  
  describe '#PATCH/PUT v1/creation/:id' do
    let(:valid_creation_params) { get_json(resource: 'creation', filename: 'valid_params') }

    context 'when parameters are valid' do
	    it 'updates the creation and responds with status 200' do
		    user = FactoryBot.create(:user)
		    headers = login_user(user: user, password: '123456')
		    creation = create(:creation, user: user)
		    update_params = {
				    "data": {
						    "type": "creations",
						    "id": creation.id,
						    "attributes": {
								  "title": "changed title"
						    }
				    }
		    }
		    expect{
			    patch "/v1/creations/#{creation.id}", params: update_params.to_json, headers: headers
		    }.to change{Creation.find(creation.id).title}.from(creation.title).to(update_params[:data][:attributes][:title])
	    end
    end
  end
  
  describe '#DELETE v1/creation/:id' do
		it 'deletes the creation and responds with status 204' do
			user = create(:user)
			creation = create(:creation, user: user)
			headers = login_user(user: user, password: '123456')
			delete "/v1/creations/#{creation.id}", headers: headers
			expect(Creation.count).to eq(0)
			expect(response.status).to eq(204)
		end
  end
  
  describe '#POST v1/creations/:id/likes' do
		it 'creates a like for the creation by current user' do
			user = create(:user)
			creation = create(:creation)
			headers = login_user(user: user, password: '123456')
			post "/v1/creations/#{creation.id}/likes", headers: headers
			expect(user.liked? Creation.find(creation.id)).to be_truthy
		end
  end
  
  describe '#DELETE v1/creations/:id/likes' do
		it 'removes the like for the creation by current user' do
			user = create(:user)
			creation = create(:creation)
			headers = login_user(user: user, password: '123456')
			user.likes creation
			delete "/v1/creations/#{creation.id}/likes", headers: headers
			expect(user.liked? Creation.find(creation.id)).to be_falsy
		end
  end
  
  describe '#GET v1/creations/:id/comments' do
	  it 'responds with list of comments and status 200' do
		  creation = create(:creation_with_comments)
		  get "/v1/creations/#{creation.id}/comments"
		  res = JSON.parse(response.body)
		  expect(res["data"].count).to eq(creation.comments.count)
		  expect(response.status).to eq(200)
	  end
  end
  
  describe '#POST v1/creations/:id/comments' do
	  context 'when params are valid' do
		  it 'creates and responds with comment with status 201' do
			  user = create(:user)
			  creation = create(:creation)
			  headers = login_user(user: user, password: '123456')
			  valid_params = get_json(resource: 'comment', filename: 'valid_params')
			  valid_params["data"]["attributes"] = attributes_for(:comment)
			  expect{
				  post "/v1/creations/#{creation.id}/comments", headers: headers, params: valid_params.to_json
			  }.to change{Creation.last.comments.count}.from(0).to(1)
			  res = JSON.parse(response.body)

			  expect(res["data"]["type"]).to eq("comments")
			  expect(response.status).to eq(201)
		  end
	  end
  end
  
  describe '#DELETE v1/creations/:id/comments/:id' do
	  it 'deletes the comment and responds with status 204' do
		  user = create(:user)
		  creation = create(:creation)
		  comment = create(:comment, user: user, commentable: creation)
		  headers = login_user(user: user, password: '123456')
		  expect{
			  delete "/v1/creations/#{creation.id}/comments/#{comment.id}", headers: headers
		  }.to change{Creation.last.comments.count}.from(1).to(0)
		  expect(response.status).to eq(204)
	  end
  end
	
	describe '#GET v1/creations/:id/user' do
		it 'responds with user and status 200' do
			user = create(:user)
			creation = create(:creation, user: user)
			get "/v1/creations/#{creation.id}/user"
			res = JSON.parse(response.body)
			expect(res["data"]["id"]).to eq(user.id)
			expect(response.status).to eq(200)
		end
	end
	
	describe '#GET v1/creations/:id/category' do
		it 'responds with category and status 200' do
			category = create(:category)
			creation = create(:creation, category: category)
			get "/v1/creations/#{creation.id}/category"
			res = JSON.parse(response.body)
			expect(res["data"]["id"]).to eq(category.id)
			expect(response.status).to eq(200)
		end
	end

  describe '#GET v1/creations/:id/license' do
	  it 'responds with license and status 200' do
		  license = create(:license)
		  creation = create(:creation, license: license)
		  get "/v1/creations/#{creation.id}/license"
		  res = JSON.parse(response.body)
		  expect(res["data"]["id"]).to eq(license.id)
		  expect(response.status).to eq(200)
	  end
  end
	
end