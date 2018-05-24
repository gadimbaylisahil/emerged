require 'rails_helper'
describe Follow, type: :model do
  describe 'Creation' do
    subject { FactoryBot.create(:follow) }
    it { is_expected.to be_valid }
  end
end