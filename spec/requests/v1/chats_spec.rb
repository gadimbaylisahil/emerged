# require 'rails_helper'
#
# describe 'Chat API', type: :request do
#   let(:user)       { FactoryBot.create(:user) }
#   let(:other_user) { FactoryBot.create(:user) }
#
#   let(:headers)    { login_user(user: user, password: '123456') }
#
#   describe '#GET v1/chats' do
#     let(:chat)       { FactoryBot.create(:chat_with_messages, user: user, other_user: other_user) }
#
#     before do
#       get "/chats/", headers: headers
#     end
#
#     it 'responds with list of current chats' do
#       expect(response.body).to eq(ChatSerializer.new(user.chats,
#                                                      include_resources( %w[messages users])).serialized_json)
#     end
#
#     it 'responds with http status 200' do
#       expect(response.status).to eq(200)
#     end
#   end
#
#   describe '#GET v1/chats/:id' do
#     let(:chat)       { FactoryBot.create(:chat_with_messages, user: user, other_user: other_user) }
#
#     before do
#       get "/chats/#{chat.id}", headers: headers
#     end
#
#     it 'responds with chat' do
#       expect(response.body).to eq(ChatSerializer.new(chat,
#                                                      include_resources( %w[messages users])).serialized_json)
#     end
#
#     it 'responds with http status 200' do
#       expect(response.status).to eq(200)
#     end
#   end
#
#   describe '#POST v1/chats' do
#     context "when chat doesn't yet exist" do
#       before do
#         post '/chats', params: { receiver_username: other_user.username }, headers: headers
#       end
#
#       it 'creates a chat' do
#         expect(user.chats.count).to eq(1)
#       end
#
#       it 'responds with chat' do
#         expect(response.body).to eq(ChatSerializer.new(user.chats.last,
#                                                        include_resources( %w[messages users])).serialized_json)
#       end
#
#       it 'reponds with http status 201' do
#         expect(response.status).to eq(201)
#       end
#     end
#
#     context "when chat already exists" do
#       let!(:chat) { FactoryBot.create(:chat_with_messages, user: user, other_user: other_user) }
#
#       before do
#         post '/chats', params: { receiver_username: other_user.username }, headers: headers
#       end
#
#       it 'does not create a chat' do
#         expect(user.chats.count).to eq(1)
#       end
#
#       it 'responds with chat' do
#         expect(response.body).to eq(ChatSerializer.new(user.chats.last,
#                                                        include_resources( %w[messages users])).serialized_json)
#       end
#
#       it 'reponds with http status 200' do
#         expect(response.status).to eq(200)
#       end
#     end
#   end
#
#   describe '#DELETE /v1/chats/:id' do
#     let(:chat) { FactoryBot.create(:chat_with_messages, user: user, other_user: other_user) }
#
#     it 'deletes users subscription to chat' do
#       delete "/chats/#{chat.id}", headers: headers
#       expect(user.chats.count).to eq(0)
#     end
#
#     it 'does not delete real chat' do
#       delete "/chats/#{chat.id}", headers: headers
#       expect(chat).to_not be_nil
#     end
#
#     it 'responds with http status 204' do
#       delete "/chats/#{chat.id}", headers: headers
#       expect(response.status).to eq(204)
#     end
#   end
#
#   describe '#POST /chats/:id/messages' do
#     let(:chat) { FactoryBot.create(:chat_with_subscribers, user: user, other_user: other_user) }
#
#     context 'when params are valid' do
#       let(:valid_message_params) { attributes_for(:message) }
#       before do
#         post "/chats/#{chat.id}/messages", params: valid_message_params, headers: headers
#       end
#
#       it 'creates a new message in chat' do
#         expect(chat.messages.count).to eq(1)
#       end
#
#       it 'responds with message' do
#         expect(response.body).to eq(MessageSerializer.new(chat.messages.last).serialized_json)
#       end
#
#       it 'responds with http status 201' do
#         expect(response.status).to eq(201)
#       end
#     end
#   end
# end
