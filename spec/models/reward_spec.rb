require 'rails_helper'
describe Reward, type: :model do
  describe 'Creation' do
    subject { FactoryBot.create(:reward) }
    it { is_expected.to be_valid }
  end

  describe 'Relationships' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:supports) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_least(4) }
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_presence_of(:amount_cents) }
  end

  describe 'Callbacks' do
    it {is_expected.to monetize(:amount_cents) }
  end
end