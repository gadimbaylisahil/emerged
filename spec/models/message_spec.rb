require 'rails_helper'

describe Message, type: :model do
  describe 'Creation' do
    subject { FactoryBot.create(:message) }
    it { is_expected.to be_valid }
  end

  describe 'Relationships' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:chat) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:content) }
  end
end