Rails.application.routes.draw do
  devise_for :users

  scope module: :v1 do

    # Creations
    resources :creations do
      # Likes
      resource :likes, only: %i[create destroy]
      member do
        put 'publish' => 'stories#publish'
        put 'unpublish' => 'stories#unpublish'
      end
    end

    # Discovery
    get 'discover-creations' => 'discovery#creations'
    get 'discover-stories' => 'discovery#stories'

    # Stories
    resources :stories do
      # Likes
      resource :likes, only: %i[create destroy]
      member do
        put 'publish' => 'stories#publish'
        put 'unpublish' => 'stories#unpublish'
      end
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

    # Authentication related endpoints
    resource :registrations, only: %i[create]
    resource :sessions, only: %i[create destroy]
  end
end
