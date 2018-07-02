require 'api_constraints'

EmergedApi::Application.routes.draw do
  devise_for :users
  # Action Cable
  mount ActionCable.server => '/cable'

  scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do

    # Creations
    resources :creations do
      collection do
        get 'discover'
      end
      resource  :likes,    only: %i[create destroy]
      resources :comments, only: %i[create destroy]
    end

    # Stories
    resources :stories do
      collection do
        get 'discover'
      end
      resource  :likes,    only: %i[create destroy]
      resources :comments, only: %i[create destroy]
    end

    # Users
    resources :users do
      resource :follows, only: %i[create destroy]
      resources :rewards
    end

    # Notifications
    resources :notifications, only: %i[index] do
      collection do
        get 'unread'
        put 'mark_read'
      end
    end

    # Supports
    resources :supports, only: %i[index show create]

    # Payments
    resources :payments, only: %i[create]
    post '/stripe/charge'  => 'stripe#charge'
    post '/stripe/webhook' => 'stripe#webhook'

    # Chats and Messages - Not nested under users as it will always be for current users.
    resources :chats, only: %i[index show create destroy] do
      resources :messages, only: %i[create]
    end

    # Authentication related endpoints
    resource :registrations, only: %i[create]
    resource :sessions, only: %i[create destroy]
  end
end
