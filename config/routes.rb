Rails.application.routes.draw do
  devise_for :users
  resources :users do
    resource :artist_profiles
    resource :supporter_profiles
  end
  resources :creations
  resources :stories
  root 'artists#show'
end
