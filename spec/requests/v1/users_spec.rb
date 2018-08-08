require 'rails_helper'
describe 'User API', type: :request do
  describe '#GET v1/users' do
    it 'responds with users and status 200' do
	    users = create_list(:user, 5)
	    get "/v1/users"
	    res = JSON.parse(response.body)
	    expect(res["data"].count).to eq(users.count)
	    expect(response.status).to eq(200)
    end
  end

  describe '#GET v1/users/:id' do
	  it 'responds with user and status 200' do
		  user = create(:user)
		  get "/v1/users/#{user.id}"
		  res = JSON.parse(response.body)
		  expect(res["data"]["type"]).to eq("users")
		  expect(response.status).to eq(200)
	  end
  end

  describe '#PATCH/PUT /users/:id' do
    let!(:user) { FactoryBot.create(:user) }
    let(:headers) { login_user(user: user, password: '123456') }

    context 'when params are valid' do
			it 'updates the user and response with 200' do
				user = create(:user)
				headers = login_user(user: user, password: '123456')
				update_params = {
						"data": {
								"type": "users",
								"id": user.id,
								"attributes": {
										"first-name": 'test-name'
								}
						}
				}
				patch "/v1/users/#{user.id}", headers: headers, params: update_params.to_json
				expect(User.find(user.id).first_name).to eq('test-name')
				expect(response.status).to eq(200)
			end
    end
  end
  
  describe '#DELETE v1/users/:id' do
		it 'deletes the user and responds with 204' do
			user = create(:user)
			headers = login_user(user: user, password: '123456')
			delete "/v1/users/#{user.id}", headers: headers
			expect{User.find(user.id)}.to raise_exception(ActiveRecord::RecordNotFound)
			expect(response.status).to eq(204)
		end
  end
	
	describe '#GET v1/users/:id/creations' do
		it 'responds with creations of user and status 200' do
			user = create(:user)
			creations = create_list(:creation, 5, user: user)
			get "/v1/users/#{user.id}/creations"
			res = JSON.parse(response.body)
			expect(res["data"].count).to eq(creations.count)
			expect(response.status).to eq(200)
		end
	end
 
	# TODO: Policies will be added to guard the access
	describe '#GET v1/users/:id/notifications' do
		it 'lists notifications for the user and status 200' do
			user = create(:user)
			notifications = create_list(:notification, 5, recipient_user: user)
			headers = login_user(user: user, password: '123456')
			get "/v1/users/#{user.id}/notifications", headers: headers
			res = JSON.parse(response.body)
			expect(res["data"].count).to eq(notifications.count)
			expect(response.status).to eq(200)
		end
	end
end