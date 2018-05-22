require 'rails_helper'
describe Chat, type: :model do
  describe 'Creation' do
    subject { FactoryBot.create(:chat) }
    it { is_expected.to be_valid }
  end

  describe 'Relationships' do
    it { is_expected.to have_many(:messages).dependent(:destroy) }
    it { is_expected.to have_many(:subscriptions).dependent(:destroy) }
    it { is_expected.to have_many(:users).through(:subscriptions) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:identifier) }
    it { is_expected.to validate_uniqueness_of(:identifier).case_insensitive }
  end
end