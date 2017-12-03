Rails.application.routes.draw do
  devise_for :users
  resources :creations
  resources :artists do
    resources :stories
  end
  resources :stories
  root 'artists#show'
end
