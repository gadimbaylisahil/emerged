Rails.application.routes.draw do
  devise_for :artists
  devise_for :users
  resources :artists do
    resources :stories
    resources :creations
  end
  resources :creations
  resources :stories
  root 'artists#show'
end
