require 'rails_helper'

RSpec.describe PaymentMethod, type: :model do
  describe 'Creation' do
    subject { FactoryBot.create(:payment_method) }
    it { is_expected.to be_valid }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:shorthand) }
  end
end
