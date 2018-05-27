module V1
  class MessagesController < V1::ApplicationController
    before_action :authenticate_with_token

    def create
      chat = find_chat
      message = current_user.messages.new(content: params[:content], chat: chat)
      message.save!
      render json: MessageSerializer.new(message), status: :created
      # TODO: Bring on later
      # if message.save!
      #   ActionCable.server.broadcast("messages_#{message_params[:chat_id]}",
      #                                message: @message.content,
      #                                user: current_user.username)
      # end
    end

    private

    def find_chat
      current_user.chats.find_by!(id: params[:chat_id])
    end
  end
end