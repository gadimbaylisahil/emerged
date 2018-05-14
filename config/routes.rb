Rails.application.routes.draw do
  devise_for :users

  scope module: :v1 do

    # Creations
    resources :creations do
      member do
        put 'like' => 'stories#like'
        put 'unlike' => 'stories#unlike'
        put 'publish' => 'stories#publish'
        put 'unpublish' => 'stories#unpublish'
      end
    end

    # Discovery
    get 'discover-creations' => 'discovery#creations'
    get 'discover-stories' => 'discovery#stories'

    # Stories
    resources :stories do
      member do
        put 'like' => 'stories#like'
        put 'unlike' => 'stories#unlike'
        put 'publish' => 'stories#publish'
        put 'unpublish' => 'stories#unpublish'
      end
    end

    # Rewards
    resources :rewards

    # Users
    resources :users do
      member do
        put 'follow' => 'users#follow'
        put 'unfollow' => 'users#unfollow'
      end
    end

    # Authentication related endpoints
    resource :registrations, only: %i[create]
    resource :sessions, only: %i[create destroy]
  end
end
