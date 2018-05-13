Rails.application.routes.draw do
  devise_for :users
  namespace :v1 do
    resources :creations
    resources :stories
    resources :rewards
    resource :sessions, only: %i[create destroy]
  end
end
