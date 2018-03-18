class ChatsController < ApplicationController
  layout 'dashboard'
  before_action :require_login
  before_action :set_sender_and_receiver, only: %i[index show create]

  def index
    @chats = current_user.chats
    @users_with_history = current_user.users_with_history
  end

  def new

  end

  def create
    @chat = Chat.new(identifier: SecureRandom.hex)
    unless @chat.persisted?
      @chat.save
      @chat.subscriptions.create(user: @sender)
      @chat.subscriptions.create(user: @receiver)
    end
    redirect_to user_chat_path(@sender, @chat, receiver: @receiver)
  end

  def show
    @chat = @sender.current_chat_with(@receiver)
    @message = Message.new
  end

  private

  def set_sender_and_receiver
    @sender = current_user
    @receiver = User.find(params[:receiver]) if params[:receiver].present?
  end
end
