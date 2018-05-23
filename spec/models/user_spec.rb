require 'rails_helper'
RSpec.describe User, type: :model do

  describe 'Creation' do
    subject { FactoryBot.create(:user) }
    it { is_expected.to be_valid }
  end

  describe 'Relationships' do
    it { is_expected.to have_many(:received_supports).with_foreign_key('creator_id').class_name('Support') }
    it { is_expected.to have_many(:given_supports).with_foreign_key('supporter_id').class_name('Support') }
    it { is_expected.to have_many(:notifications).with_foreign_key('recipient_user_id').dependent(:destroy) }
    it { is_expected.to have_many(:creations).dependent(:destroy) }
    it { is_expected.to have_many(:messages).dependent(:nullify) }
    it { is_expected.to have_many(:subscriptions).dependent(:destroy) }
    it { is_expected.to have_many(:chats).through(:subscriptions) }
    it { is_expected.to have_many(:stories).dependent(:destroy) }
    it { is_expected.to have_many(:rewards).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:activities).dependent(:destroy) }

  # TODO: Bring on ActiveStorage matchers
  end

  describe 'Validations' do
    subject { FactoryBot.create(:user) }
    it { is_expected.to validate_length_of(:username)
                            .is_at_least(6)
                            .is_at_most(40) }

    it { is_expected.to validate_uniqueness_of(:username)
                            .case_insensitive }

    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_presence_of(:email) }
  end

  describe 'Callbacks' do
    let(:user) { FactoryBot.create(:user) }
    it 'is expected to parameterize username on save' do
      username = 'ASFD/??dafsdf--=3'
      user.update(username: username)
      expect(user.username).to eq(username.parameterize)
    end

    it 'is expected to set default settings' do
      expect(user.receive_emails_for_follows).to eq(true)
      expect(user.receive_emails_for_likes).to eq(true)
      expect(user.receive_emails_from_emerged).to eq(true)
    end
  end
end