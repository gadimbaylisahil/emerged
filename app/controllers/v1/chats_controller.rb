module V1
  class ChatsController < V1::ApplicationController
    before_action :authenticate_with_token
    
    # TODO: add spec for incluedd resources
    def index
      chats = current_user.chats
      resources = {
          messages: {
              fields: []
          },
          users: {
		          fields: [:username]
          }
      }
      render json: ChatSerializer.new(chats, SerializationOption.run(resources)).serialized_json, status: :ok
    end
		# TODO: add spec for incluedd resources
    def show
      chat = current_user.chats.find_by!(id: params[:id])
      resources = {
		      messages: {
				      fields: []
		      }
      }
      render json: ChatSerializer.new(chat, SerializationOption.run(resources)).serialized_json, status: :ok
    end

    def create
      receiver = User.find_by!(username: params[:receiver_username])
      chat = current_user.current_chat_with(receiver)
      if chat
        render json: ChatSerializer.new(chat).serialized_json, status: :ok
      else
        chat = Chat.new(identifier: SecureRandom.hex)
        chat.save!
        create_subscriptions(chat: chat, receiver: receiver)
        render json: ChatSerializer.new(chat).serialized_json, status: :created
      end
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