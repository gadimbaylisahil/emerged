require 'rails_helper'
describe 'Sessions API', type: :request do
  describe '#Post v1/sessions' do
    let(:user) { FactoryBot.create(:user) }
    let(:password) { '123456' }

    context 'when username and password is valid' do
      it 'responds with users data' do
        res = JSON.parse(response.body)
      end
    end
  end
end