require 'rails_helper'
describe Creation, type: :model do
  describe 'Creation' do
    subject { FactoryBot.create(:creation) }
    it { is_expected.to be_valid }
  end

  describe 'Relationships' do
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:category) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_least(4).is_at_most(50) }
  end
end