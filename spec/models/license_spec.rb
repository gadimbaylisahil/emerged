require 'rails_helper'
describe License, type: :model do
  describe 'Creation' do
    subject { FactoryBot.create(:license) }
    it { is_expected.to be_valid }
  end

  describe 'Relationships' do
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
  end
end