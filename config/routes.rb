Rails.application.routes.draw do
  resources :settings
  devise_for :users
  resources :users do
    resource :profile, only: %i[show edit update]
  end
  resources :creations
end
