require 'rails_helper'
describe UserSerializer, type: :serializer do
	let(:user) { FactoryBot.create(:user) }
	
	context 'when serializing a User' do
		let(:serialized_user) { UserSerializer.new(user).serialized_json }
		subject {
			JSON.parse(serialized_user)
		}
		
		it 'return a valid json' do
			expect(subject["data"].present?).to be_truthy
		end
		
		it 'contains listed attributes of user' do
			expect(subject["data"]["attributes"]["first_name"]).to eq(user.first_name)
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
end