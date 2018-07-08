require 'rails_helper'
describe Category, type: :model do
  describe 'Creation' do
    subject { FactoryBot.create(:category) }
    it { is_expected.to be_valid }
  end

  describe 'Relationships' do
    it { is_expected.to have_many(:creations) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(3).is_at_most(20) }
  end
end