class MessagesController < ApplicationController
  before_action :authenticate_with_token, only: %i[create]
  def create
    @message = current_user.messages.build(message_params)
    if @message.save
      ActionCable.server.broadcast("messages_#{message_params[:chat_id]}",
                                   message: @message.content,
                                   user: current_user.username)
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :chat_id)
  end
end
