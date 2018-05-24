require 'rails_helper'
describe Subscription, type: :model do
  describe 'Creation' do
    subject { FactoryBot.create(:subscription) }
    it { is_expected.to be_valid }
  end

  describe 'Relationships' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:chat) }
  end
end