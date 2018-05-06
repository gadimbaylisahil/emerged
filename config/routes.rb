Rails.application.routes.draw do
  resources :comments
  resources :rewards
  resources :stories do
    resources :comments, module: :stories
    member do
      put 'like' => 'stories#like'
      put 'unlike' => 'stories#unlike'
    end
  end
  mount ActionCable.server => '/cable'
  mount ActiveStorage::Engine, at: '/'
  resources :passwords, controller: 'passwords', only: %i[create new]
  resource :session, controller: 'sessions', only: %i[create new destroy]

  resources :users, controller: 'users', only: %i[new index edit update destroy]

  resources :users, controller: 'users', only: %i[create] do
    resource :password,
             controller: 'passwords',
             only: %i[create edit update]
  end

  resources :users, controller: 'users', only: %i[new create] do
    resources :chats, only: %i[new index show create]
  end

  resources :users do
    member do
      put 'follow' => 'users#follow'
      put 'unfollow' => 'users#unfollow'
      resources :settings, only: %i[edit update]
    end
  end

  resources :messages, only: %i[create]

  get 'dashboard' => 'users#dashboard', as: 'dashboard'
  get '/sign_in' => 'sessions#new', as: 'sign_in'
  delete '/sign_out' => 'sessions#destroy', as: 'sign_out'
  get '/sign_up' => 'users#new', as: 'sign_up'

  resources :rewards
  resources :creations do
    resources :comments, module: :creations
    member do
      put 'like' => 'creations#like'
      put 'unlike' => 'creations#unlike'
    end
  end
  resources :notifications do
    collection do
      post :mark_as_read
    end
  end

  get 'discovery-creations' => 'discovery#creations', as: 'discovery_creations'
  get 'discovery-stories' => 'discovery#stories', as: 'discovery_stories'

  root 'discovery#creations'
end
