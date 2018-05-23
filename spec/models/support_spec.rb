require 'rails_helper'
describe Support, type: :model do
  describe 'Creation' do
    subject { FactoryBot.create(:support) }
    it { is_expected.to be_valid }
  end

  describe 'Relationships' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_one(:payment) }
    it { is_expected.to belong_to(:supportable) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:amount_cents) }
    it { is_expected.to validate_numericality_of(:amount_cents) }
  end

  describe 'Callbacks' do
    it { is_expected.to monetize(:amount_cents)}
  end
end