module V1
  class ChatsController < V1::ApplicationController
    before_action :authenticate_with_token
    
    def index
      chats = current_user.chats
      render json: JSONAPI::ResourceSerializer.new(ChatResource).
          serialize_to_hash(ChatResource.new(chats, context))
    end
    
    def show
      chat = current_user.chats.find_by!(id: params[:id])
      render json: JSONAPI::ResourceSerializer.new(ChatResource).
          serialize_to_hash(ChatResource.new(chat, context))
    end

    def create
      receiver = User.find_by!(id: params[:id] || params[:user_id])
      chat = current_user.current_chat_with(receiver)
      status = :ok
      unless chat
        chat = Chat.new(identifier: SecureRandom.hex)
        chat.save!
        create_subscriptions(chat: chat, receiver: receiver)
        status = :created
      end
      render json: JSONAPI::ResourceSerializer.new(ChatResource).
          serialize_to_hash(ChatResource.new(chat, context)), status: status
    end

    def destroy
      chat = current_user.chats.find_by!(id: params[:id])
      subscription = current_user.subscriptions.find_by!(chat: chat)
      subscription.destroy
      head(:no_content)
    end

    private

    def create_subscriptions(chat:, receiver:)
      chat.subscriptions.create(user: current_user)
      chat.subscriptions.create(user: receiver)
    end
  end
end