require 'rails_helper'
describe CreationSerializer, type: :serializer do
	let(:creation) { FactoryBot.create(:creation) }
	let(:serialized_creation) { CreationSerializer.new(creation).serialized_json }
	subject {
		JSON.parse(serialized_creation)
	}
	
	context 'when serializing Creation' do
		it 'returns a valid json' do
			expect(subject["data"].present?).to be_truthy
		end
	end
	
	describe 'Attributes' do
		it 'contains content' do
			expect(subject["data"]["attributes"]["content"]).to eq(creation.content)
		end
		
		it 'contains description' do
			expect(subject["data"]["attributes"]["description"]).to eq(creation.description)
		end
		
		it 'contains total likes' do
			expect(subject["data"]["attributes"]["total_likes"]).to eq(creation.get_likes.count)
		end
		
		it 'contains total likes' do
			expect(subject["data"]["attributes"]["total_comments"]).to eq(creation.comments.count)
		end
		
		it 'contains liker_ids' do
			expect(subject["data"]["attributes"]["liker_ids"]).to eq(creation.votes_for.up.voters.pluck(:id))
		end
	end
	
	describe 'Relationships' do
		it 'contains user' do
			expect(subject["data"]["relationships"]["user"]).to be_truthy
		end
		it 'contains category' do
			expect(subject["data"]["relationships"]["category"]).to be_truthy
		end
		it 'contains comments' do
			expect(subject["data"]["relationships"]["comments"]).to be_truthy
		end
	end
	
	describe 'Links' do
		it 'contains self link' do
			expect(subject["data"]["links"]["self"]).to eq("http://localhost:8081/creations/#{creation.id}")
		end
	end
end