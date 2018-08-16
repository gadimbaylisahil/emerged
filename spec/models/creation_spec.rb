require 'rails_helper'
describe Creation, type: :model do
  describe 'Creation' do
    subject { FactoryBot.create(:creation) }
    it { is_expected.to be_valid }
  end

  describe 'Relationships' do
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:likes).dependent(:destroy)}
    it { is_expected.to belong_to(:category) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_least(4).is_at_most(50) }
  end
	
	describe 'Named Scopes' do
		before do
			FactoryBot.create_list(:creation, 10)
		end
		describe 'Sorting Scopes' do
			it 'has named scope trending which orders by trending ratio' do
				sorted_result = Creation.where(id: Creation.all.sort_by(&:trending_ratio).map(&:id))
				expect(Creation.trending).to eq(sorted_result)
			end
		end
	end
end