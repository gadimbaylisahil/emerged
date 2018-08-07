module V1
  class MessagesController < V1::ApplicationController
    before_action :authenticate_with_token
    
    def index
      chat = find_chat
      messages = chat.messages
      render json: JSONAPI::ResourceSerializer.new(MessageResource).
          serialize_to_hash(MessageResource.new(messages, context))
    end

    def create
      chat = find_chat
      message = current_user.messages.new(content: params[:content], chat: chat)
      message.save!
      render json: JSONAPI::ResourceSerializer.new(MessageResource).
          serialize_to_hash(MessageResource.new(message, context))
    end

    private

    def find_chat
      current_user.chats.find_by!(id: params[:chat_id])
    end
  end
end