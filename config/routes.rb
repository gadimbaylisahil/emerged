Rails.application.routes.draw do
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

  resources :messages, only: %i[create]

  get '/dashboard' => 'users#dashboard', as: 'dashboard'

  get '/sign_in' => 'sessions#new', as: 'sign_in'
  delete '/sign_out' => 'sessions#destroy', as: 'sign_out'
  get '/sign_up' => 'users#new', as: 'sign_up'

  resources :creations

  get '/discover' => 'creations#discover', as: 'discover'
end
