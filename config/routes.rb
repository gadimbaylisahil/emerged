Rails.application.routes.draw do
  devise_for :users
  resources :users
  resource :profile, only: %i[edit update]
  resources :creations
  resources :stories
end
