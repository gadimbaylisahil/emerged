require 'rails_helper'
describe ChatSerializer, type: :serializer do
	let(:chat) { FactoryBot.create(:chat) }
	let(:serialized_chat) { ChatSerializer.new(chat).serialized_json }
	subject {
		JSON.parse(serialized_chat)
	}
	
	context 'when serializing Creation' do
		it 'returns a valid json' do
			expect(subject["data"].present?).to be_truthy
		end
	end
	
	describe 'Attributes' do
		it 'contains identifier' do
			expect(subject["data"]["attributes"]["identifier"]).to eq(chat.identifier)
		end
	end

	describe 'Relationships' do
		it 'contains users' do
			expect(subject["data"]["relationships"]["users"]).to be_truthy
		end
		it 'contains subscriptions' do
			expect(subject["data"]["relationships"]["subscriptions"]).to be_truthy
		end
		it 'contains messages' do
			expect(subject["data"]["relationships"]["messages"]).to be_truthy
		end
	end
end