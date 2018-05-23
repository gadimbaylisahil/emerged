require 'rails_helper'
describe Comment, type: :model do
  describe 'Creation' do
    subject { FactoryBot.create(:comment) }
    it { is_expected.to be_valid }
  end

  describe 'Relationships' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:commentable) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:body) }
  end
end