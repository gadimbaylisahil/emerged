class ChatsController < ApplicationController
  layout 'dashboard'
  before_action :require_login

  before_action :set_sender, only: %i[index show create]
  before_action :set_receiver, only: %i[index show]
  before_action :set_receiver_from_username, only: %i[create]

  def index
    @chats = current_user.chats
    @users_with_history = current_user.users_with_history
  end

  def new
    @chat = Chat.new
  end

  def create
    @chat = @sender.current_chat_with(@receiver) || Chat.new(identifier: SecureRandom.hex)

    unless @chat.new_record?
      @chat.messages.create(content: params[:content], user: @sender)
      redirect_to user_chat_path(@sender, @chat, receiver: @receiver)
      return
    end

    @chat.save
    @chat.subscriptions.create(user: @sender)
    @chat.subscriptions.create(user: @receiver)
    @chat.messages.create(content: params[:content], user: @sender)
    redirect_to user_chat_path(@sender, @chat, receiver: @receiver)
  end

  def show
    @chat = @sender.current_chat_with(@receiver)
    @message = Message.new
  end

  private

  def set_sender
    @sender = current_user
  end

  def set_receiver
    @receiver = User.find(params[:receiver]) if params[:receiver].present?
  end

  def set_receiver_from_username
    @receiver = User.find_by(username: params[:receiver])
  end
end
