require 'rails_helper'
describe UserSerializer, type: :serializer do
	let(:user) { FactoryBot.create(:user) }
	let(:serialized_user) { UserSerializer.new(user).serialized_json }
	subject {
		JSON.parse(serialized_user)
	}
	
	context 'when serializing User' do
		it 'returns a valid json' do
			expect(subject["data"].present?).to be_truthy
		end
	end
	
	describe 'Attributes' do
		it 'contains first_name' do
			expect(subject["data"]["attributes"]["first_name"]).to eq(user.first_name)
		end
		
		it 'contains last_name' do
			expect(subject["data"]["attributes"]["last_name"]).to eq(user.last_name)
		end
		
		it 'contains username' do
			expect(subject["data"]["attributes"]["username"]).to eq(user.username)
		end
		
		it 'contains company' do
			expect(subject["data"]["attributes"]["company"]).to eq(user.company)
		end
		
		it 'contains city' do
			expect(subject["data"]["attributes"]["city"]).to eq(user.city)
		end
		
		it 'contains country' do
			expect(subject["data"]["attributes"]["country"]).to eq(user.country)
		end
		
		it 'contains about_me' do
			expect(subject["data"]["attributes"]["about_me"]).to eq(user.about_me)
		end
		
		it 'contains title' do
			expect(subject["data"]["attributes"]["title"]).to eq(user.title)
		end
		
		it 'contains website_url' do
			expect(subject["data"]["attributes"]["website_url"]).to eq(user.website_url)
		end
		
		it 'contains email' do
			expect(subject["data"]["attributes"]["email"]).to eq(user.email)
		end
		
		it 'contains display_name' do
			expect(subject["data"]["attributes"]["display_name"]).to eq(user.display_name)
		end
		
		it 'contains email' do
			expect(subject["data"]["attributes"]["email"]).to eq(user.email)
		end
		
		it 'contains following users as following_ids' do
			following_ids = user.following_by_type('User').pluck(:id)
			expect(subject["data"]["attributes"]["subscription_ids"]).to eq(following_ids)
		end
		
		it 'contains subscribed category ids as subscribtion_ids' do
			subscription_ids = user.following_by_type('Category').pluck(:id)
			expect(subject["data"]["attributes"]["subscription_ids"]).to eq(subscription_ids)
		end
	end
	
	describe 'Relationships' do
		it 'contains creations' do
			expect(subject["data"]["relationships"]["creations"]).to be_truthy
		end
		it 'contains rewards' do
			expect(subject["data"]["relationships"]["rewards"]).to be_truthy
		end
		it 'contains given_supports' do
			expect(subject["data"]["relationships"]["given_supports"]).to be_truthy
		end
		it 'contains notifications' do
			expect(subject["data"]["relationships"]["notifications"]).to be_truthy
		end
		it 'contains messages' do
			expect(subject["data"]["relationships"]["messages"]).to be_truthy
		end
		it 'contains chats' do
			expect(subject["data"]["relationships"]["chats"]).to be_truthy
		end
		it 'contains comments' do
			expect(subject["data"]["relationships"]["comments"]).to be_truthy
		end
		it 'contains activities' do
			expect(subject["data"]["relationships"]["activities"]).to be_truthy
		end
	end
	
	describe 'Links' do
		it 'contains profile_url link' do
			expect(subject["data"]["links"]["profile_url"]).to eq("http://localhost:8081/users/#{user.id}")
		end
	end
end