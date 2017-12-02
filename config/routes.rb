Rails.application.routes.draw do
  devise_for :users
  resources :creations
  resources :stories
  root 'stories#index'
end
