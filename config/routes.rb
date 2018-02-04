Rails.application.routes.draw do
  devise_for :users
  resources :users
  resource :artist_profiles, only: %i[edit update]
  resource :supporter_profiles, only: %i[edit update]
  resources :creations
  resources :stories
end
