Rails.application.routes.draw do
  devise_for :users
  # Action Cable
  mount ActionCable.server => '/cable'

  scope module: :v1 do

    # Creations
    resources :creations do
      # Likes
      resource :likes, only: %i[create destroy]
      # Comments
      resources :comments, only: %i[create destroy]
    end

    # Discovery
    get 'discover-creations' => 'discovery#creations'
    get 'discover-stories' => 'discovery#stories'

    # Stories
    resources :stories do
      # Likes
      resource :likes, only: %i[create destroy]
      # Comments
      resources :comments, only: %i[create destroy]
    end

    # Rewards
    resources :rewards

    # Notifications
    resources :notifications, only: %i[index mark_as_read]

    # Users
    resources :users do
      # Follows
      resource :follows, only: %i[create destroy]
    end

    # Chats and Messages - Not nested under users as it will always be for current users.
    resources :chats, only: %i[index show create] do
      resources :messages, only: %i[index create]
    end

    # Authentication related endpoints
    resource :registrations, only: %i[create]
    resource :sessions, only: %i[create destroy]
  end
end
