class ChatsController < ApplicationController
  layout 'dashboard'
  before_action :require_login
  before_action :find_other_user, only: %i[show create]

  def index
    @chats = current_user.chats
    @existing_chats = current_user.existing_chats
  end

  def create
    @chat = find_chat(@other_user) || Chat.new(identifier: SecureRandom.hex)
    unless @chat.persisted?
      @chat.save
      @chat.subscriptions.create(user: current_user)
      @chat.subscriptions.create(user: @other_user)
    end
    redirect_to user_chat_path(current_user, @chat, other_user: @other_user)
  end

  def show
    @chat = Chat.find(params[:id])
    @message = Message.new
  end

  private

  def find_chat(other_user)
    current_user.chats.each do |chat|
      chat.subscriptions.each do |subscription|
        if subscription.user.eql?(other_user)
          return chat
        end
      end
    end
    false
  end

  def find_other_user
    @other_user = User.find(params[:other_user])
  end
end
