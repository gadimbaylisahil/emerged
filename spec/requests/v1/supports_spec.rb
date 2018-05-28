require 'rails_helper'
describe 'Support API', type: :request do
  let(:user)    { FactoryBot.create(:user) }
  let(:headers) { login_user(user: user, password: '123456') }
  describe '#GET /v1/supports' do
    let(:reward)  { FactoryBot.create(:reward) }
    let(:support) { FactoryBot.create(:support, supportable: reward,
                                       supporter: user, creator: reward.user,
                                       amount_cents: reward.amount_cents )}

    context 'when all supports requested' do
      before do
        get "/supports", headers: headers
      end
      it 'responds with both received and given supports' do
        supports = user.given_supports.or(user.received_supports)
        expect(response.body).to eq(SupportSerializer.new(supports).serialized_json)
      end

      it 'responds with http status 200' do
        expect(response.status).to eq(200)
      end
    end

    context 'when received supports requested' do
      before do
        get "/supports?type=received", headers: headers
      end
      it 'responds with received supports' do
        expect(response.body).to eq(SupportSerializer.new(user.received_supports).serialized_json)
      end

      it 'responds with http status 200' do
        expect(response.status).to eq(200)
      end
    end

    context 'when given supports requested' do
      before do
        get "/supports?type=given", headers: headers
      end

      it 'responds with given supports' do
        expect(response.body).to eq(SupportSerializer.new(user.given_supports).serialized_json)
      end

      it 'responds with http status 200' do
        expect(response.status).to eq(200)
      end
    end
  end

  describe '#GET /v1/supports/:id' do
    let(:reward)  { FactoryBot.create(:reward) }
    let(:support) { FactoryBot.create(:support, supportable: reward,
                                       supporter: user, creator: reward.user,
                                       amount_cents: reward.amount_cents )}
    context 'when logged in as supporter' do
      before do
        get "/supports/#{support.id}", headers: headers
      end

      it 'responds with support' do
        expect(response.body).to eq(SupportSerializer.new(support).serialized_json)
      end

      it 'responds with http status 200' do
        expect(response.status).to eq(200)
      end
    end

    context 'when logged in as receiver of support' do
      let(:creator) { FactoryBot.create(:user) }
      let(:headers_for_creator) { login_user(user: creator, password: '123456') }

      before do
        get "/supports/#{support.id}", headers: headers_for_creator
      end

      it 'responds with support' do
        expect(response.body).to eq(SupportSerializer.new(support).serialized_json)
      end

      it 'responds with http status 200' do
        expect(response.status).to eq(200)
      end
    end
  end

  describe '#POST /v1/supports' do

  end
end