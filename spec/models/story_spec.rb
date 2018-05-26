require 'rails_helper'

describe Story, type: :model do
  describe 'Creation' do
    subject { FactoryBot.create(:story) }
    it { is_expected.to be_valid }
  end

  describe 'Relationships' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:category) }
    it { is_expected.to have_many(:comments).dependent(:destroy)}
  end

  describe 'Validity' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_length_of(:title).is_at_least(4).is_at_most(50) }
  end
end