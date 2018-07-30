require 'rails_helper'
describe LicenseSerializer, type: :serializer do
	let(:license) { FactoryBot.create(:license) }
	let(:serialized_license) { LicenseSerializer.new(license).serialized_json }
	subject {
		JSON.parse(serialized_license)
	}
	
	context 'when serializing License' do
		it 'returns a valid json' do
			expect(subject["data"].present?).to be_truthy
		end
	end
	
	describe 'Attributes' do
		it 'contains identifier' do
			expect(subject["data"]["attributes"]["name"]).to eq(license.name)
		end
		
		it 'contains description' do
			expect(subject["data"]["attributes"]["description"]).to eq(license.description)
		end
		
		it 'contains shorthand' do
			expect(subject["data"]["attributes"]["shorthand"]).to eq(license.shorthand)
		end
	end
	
	describe 'Relationships' do
	end
end