require 'rails_helper'
describe Support, type: :model do
  describe 'Creation' do
    subject { FactoryBot.create(:support) }
    it { is_expected.to be_valid }
  end

  describe 'Relationships' do
  end

  describe 'Validations' do
  end

  describe 'Callbacks' do
  end
end