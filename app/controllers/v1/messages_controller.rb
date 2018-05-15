module V1
  class MessagesController < V1::ApplicationController
    before_action :authenticate_with_token

    def index
      chat = find_chat
      messages = chat.messages
      render json: MessageSerializer.new(messages).serialized_json, status: :ok
    end

    def create
      chat = find_chat
      message = current_user.messages.new(content: params[:content], chat: chat)
      message.save!
      render json: message, status: :ok
      # TODO: Bring on later
      # if message.save!
      #   ActionCable.server.broadcast("messages_#{message_params[:chat_id]}",
      #                                message: @message.content,
      #                                user: current_user.username)
      # end
    end

    private

    def find_chat
      Chat.find_by!(id: params[:chat_id])
    end
  end
end