require 'rails_helper'
describe Activity, type: :model do
  describe 'Creation' do
    subject { FactoryBot.create(:activity) }
    it { is_expected.to be_valid }
  end

  describe 'Relationships' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:subject) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:activity_type) }
  end
end