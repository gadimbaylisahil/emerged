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
			it 'has named scope most_liked which orders by likes' do
				sorted_result = Creation.order("creations.cached_votes_up DESC, creations.created_at DESC")
				expect(Creation.most_liked).to eq(sorted_result)
			end
			it 'has named scope most_viewed which orders by views' do
				sorted_result = Creation.order("creations.impressions_count DESC, creations.impressions_count DESC")
				expect(Creation.most_viewed).to eq(sorted_result)
			end
			it 'has named scope recent which orders by created_at date' do
				sorted_result = Creation.order("creations.created_at DESC")
				expect(Creation.recent).to eq(sorted_result)
			end
			it 'has named scope most_shared which orders by number of shares' do
				sorted_result = Creation.order("creations.number_of_shares DESC, creations.number_of_shares DESC")
				expect(Creation.most_shared).to eq(sorted_result)
			end
			it 'has named scope most_discussed which orders by number of comments' do
				sorted_result = Creation.order("creations.cached_comments_count DESC, creations.cached_comments_count DESC")
				expect(Creation.most_discussed).to eq(sorted_result)
			end
			it 'has named scope trending which orders by trending ratio' do
				sorted_result = Creation.where(id: Creation.all.sort_by(&:trending_ratio).map(&:id))
				expect(Creation.trending).to eq(sorted_result)
			end
		end
	end
end