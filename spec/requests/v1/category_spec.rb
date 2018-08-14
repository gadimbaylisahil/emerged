require 'rails_helper'

describe 'Category API', type: :request do
	
	describe '#GET v1/categories' do
		it 'responds with list of categories and status 200' do
			categories = create_list(:category, 5)
			get '/v1/categories'
			res = JSON.parse(response.body)
			expect(res["data"].count).to eq(categories.count)
			expect(response.status).to eq(200)
		end
	end
	
	describe '#GET v1/categories/:id' do
		it 'responds with category and status 200' do
			category = create(:category)
			get "/v1/categories/#{category.id}"
			res = JSON.parse(response.body)
			expect(res["data"]["type"]).to eq("categories")
			expect(res["data"]["id"]).to eq(category.id)
			expect(response.status).to eq(200)
		end
	end
	
	describe '#GET v1/categories/:id/creations' do
		it 'responds with creations and status 200' do
			category = create(:category)
			creations = create_list(:creation, 5, category: category)
			get "/v1/categories/#{category.id}/creations"
			res = JSON.parse(response.body)
			expect(res["data"].count).to eq(creations.count)
			expect(response.status).to eq(200)
		end
	end
	
	describe '#POST v1/categories/:id/subscribe' do
		it 'subscribes the user to category and responds with 201' do
			category = create(:category)
			user = create(:user)
			headers = login_user(user: user, password: '123456')
			post "/v1/categories/#{category.id}/subscribe", headers: headers
			expect(user.follows? category).to eq(true)
			expect(response.status).to eq(201)
		end
	end
	
	describe '#DELETE v1/categories/:id/unsubscribe' do
		it 'unsubscribes the user from category and responds with 204' do
			category = create(:category)
			user = create(:user)
			user.follow category
			headers = login_user(user: user, password: '123456')
			delete "/v1/categories/#{category.id}/unsubscribe", headers: headers
			expect(user.follows? category).to eq(false)
			expect(response.status).to eq(204)
		end
	end
end
