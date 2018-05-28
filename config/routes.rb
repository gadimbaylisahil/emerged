require 'api_constraints'

EmergedApi::Application.routes.draw do
  devise_for :users
  # Action Cable
  mount ActionCable.server => '/cable'

  scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do

    # Creations
    resources :creations do
      resource  :likes,    only: %i[create destroy]
      resources :comments, only: %i[create destroy]
    end

    # Stories
    resources :stories do
      resource  :likes,    only: %i[create destroy]
      resources :comments, only: %i[create destroy]
    end

    # Users
    resources :users do
      resource :follows, only: %i[create destroy]
      resources :notifications, only: %i[index]
      resources :rewards
    end

    # Supports
    resources :supports, only: %i[index show create]

    # Payments
    resources :payments, only: %i[create]

    # Chats and Messages - Not nested under users as it will always be for current users.
    resources :chats, only: %i[index show create destroy] do
      resources :messages, only: %i[create]
    end

    # Authentication related endpoints
    resource :registrations, only: %i[create]
    resource :sessions, only: %i[create destroy]
  end
end
