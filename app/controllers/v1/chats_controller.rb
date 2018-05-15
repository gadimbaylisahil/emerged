module V1
  class ChatsController < V1::ApplicationController
    before_action :authenticate_with_token

    def index
      chats = current_user.chats
      render json: ChatSerializer.new(chats).serialized_json, status: :ok
    end

    def show
      chat = current_user.chats.find_by!(id: params[:id])
      render json: ChatSerializer.new(chat).serialized_json, status: :ok
    end

    def create
      receiver = User.find_by!(username: params[:receiver_username])
      chat = current_user.current_chat_with(receiver)
      unless chat
        chat = Chat.new(identifier: SecureRandom.hex)
        chat.save!
        create_subscriptions(chat: chat, receiver: receiver)
      end
      render json: ChatSerializer.new(chat).serialized_json, status: :ok
    end

    private

    def create_subscriptions(chat:, receiver:)
      chat.subscriptions.create(user: current_user)
      chat.subscriptions.create(user: receiver)
    end
  end
end