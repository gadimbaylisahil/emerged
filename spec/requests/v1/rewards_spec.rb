require 'rails_helper'
describe 'Reward API', type: :request do
  let(:user)    { FactoryBot.create(:user_with_rewards) }
  let(:headers) { login_user(user: user, password: '123456') }

  describe '#GET v1/users/:id/rewards' do
    it 'responds with rewards and status 200' do
      get "/v1/users/#{user.id}/rewards"
      res = JSON.parse(response.body)
      expect(res["data"].count).to eq(user.rewards.count)
      expect(response.status).to eq(200)
    end
  end

  describe '#GET v1/rewards/:id' do
    it 'responds with reward and status 200' do
      get "/v1/rewards/#{user.rewards.first.id}"
      res = JSON.parse(response.body)
      expect(res["data"]["id"]).to eq(user.rewards.first.id)
      expect(response.status).to eq(200)
    end
  end

  describe '#POST v1/rewards' do
    context 'when parameters are valid' do
      it 'creates and responds  with reward and status 201' do
        valid_params = get_json(resource: "reward", filename: "valid_params")
        post "/v1/rewards", params: valid_params.to_json, headers: headers
        res = JSON.parse(response.body)
        expect(res["data"]["attributes"]["title"]).to eq(valid_params["data"]["attributes"]["title"])
        expect(response.status).to eq(201)
      end
    end
  end

  describe '#PATCH/PUT v1/rewards/:id' do
    context 'when parameters are valid' do
      context 'when user is authorised' do
        it 'updates the reward and responds with status 200' do
          headers = login_user(user: user, password: '123456')
          update_params = {
              "data": {
                  "type": "rewards",
                  "id": user.rewards.first.id,
                  "attributes": {
                      "title": "changed title"
                  }
              }
          }
          expect{
            patch "/v1/rewards/#{user.rewards.first.id}", params: update_params.to_json, headers: headers
          }.to change{Reward.find(user.rewards.first.id).title}.from(user.rewards.first.title).to(update_params[:data][:attributes][:title])
        end
      end

      context 'when user is unauthorized' do
        it 'responds with status 403' do
          some_other_user = create(:user)
          headers = login_user(user: some_other_user, password: '123456')
          update_params = {
              "data": {
                  "type": "rewards",
                  "id": user.rewards.first.id,
                  "attributes": {
                      "title": "changed title"
                  }
              }
          }
          patch "/v1/rewards/#{user.rewards.first.id}", params: update_params.to_json, headers: headers
          expect(response.status).to eq(403)
        end
      end
    end
  end
#   TODO: Decide how to handle delete logic
end