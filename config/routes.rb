Rails.application.routes.draw do
  resources :supporter_profiles
  devise_for :users
  resources :artist_profiles
  resources :creations
  resources :stories
  root 'artists#show'
end
