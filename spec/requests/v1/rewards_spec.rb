# require 'rails_helper'
# describe 'Reward API', type: :request do
#   let(:user)    { FactoryBot.create(:user_with_rewards) }
#   let(:headers) { login_user(user: user, password: '123456') }
#
#   describe '#GET v1/users/:id/rewards' do
#     before do
#       get "/users/#{user.id}/rewards"
#     end
#
#     it 'responds with rewards' do
#       expect(response.body).to eq(RewardSerializer.new(user.rewards).serialized_json)
#     end
#
#     it 'responds with http status 200' do
#       expect(response.status).to eq(200)
#     end
#   end
#
#   describe '#GET v1/rewards/:id' do
#     before do
#       get "/users/#{user.id}/rewards/#{user.rewards.last.id}"
#     end
#
#     it 'responds with reward' do
#       expect(response.body).to eq(RewardSerializer.new(user.rewards.last).serialized_json)
#     end
#
#     it 'responds with http status 200' do
#       expect(response.status).to eq(200)
#     end
#   end
#
#   describe '#POST v1/rewards' do
#     context 'when params are valid' do
#       let(:valid_reward_params) { attributes_for(:reward) }
#
#       before do
#         post "/users/#{user.id}/rewards", params: valid_reward_params, headers: headers
#       end
# 			# TODO: as uuids sort is not based on last creation reward.last won't be equeal to body
#       it 'creates and responds with reward' do
#         expect(response.body).to eq(RewardSerializer.new(user.rewards.last).serialized_json)
#       end
#
#       it 'responds with http status 201' do
#         expect(response.status).to eq(201)
#       end
#     end
#   end
#
#   describe '#PATCH/PUT v1/rewards/:id' do
#     context 'when params are valid' do
#       let!(:valid_reward_params) { attributes_for(:reward) }
#       before do
#         patch "/users/#{user.id}/rewards/#{user.rewards.last.id}", params: valid_reward_params, headers: headers
#       end
#
#       it 'updates the reward' do
#         expect(user.rewards.last.title).to eq(valid_reward_params[:title])
#       end
#
#       it 'responds with http status 200' do
#         expect(response.status).to eq(200)
#       end
#     end
#   end
#
#   describe '#DELETE v1/rewards/:id' do
#
#   end
# end