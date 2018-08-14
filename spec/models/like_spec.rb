require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'Relationships' do
    it { is_expected.to belong_to(:creation) }
    it { is_expected.to belong_to(:user) }
  end
end
