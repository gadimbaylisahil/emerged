Rails.application.routes.draw do
  resources :artist_profiles
  devise_for :users
  resources :creations
  resources :stories
  root 'artists#show'
end
