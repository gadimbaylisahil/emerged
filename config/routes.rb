require 'api_constraints'

EmergedApi::Application.routes.draw do
	devise_for :users
	# Action Cable
	mount ActionCable.server => '/cable'
	namespace :v1 do
		jsonapi_resources :users, only: %i[index show update destroy] do
			jsonapi_relationships
			member do
        delete 'follows' => 'follows#destroy'
        delete 'notifications' => 'notifications#destroy'
      end
      
			jsonapi_related_resources :notifications, only: %i[index]
      jsonapi_resources :follows, only: %i[index create]
			jsonapi_resources :chats, only: %i[index show create destroy] do
				jsonapi_relationships
        jsonapi_resources :messages
			end
		end

		jsonapi_resources :creations do
			jsonapi_relationships
			jsonapi_related_resource :user
			jsonapi_related_resource :category
			jsonapi_related_resource :license
      jsonapi_resource  :likes
      jsonapi_related_resources :likes
			jsonapi_resources :comments, only: %i[index create destroy]
		end
		
		jsonapi_resources :licenses, only: %i[index show] do
			jsonapi_relationships only: %i[index show]
		end

		jsonapi_resources :categories, only: %i[index show] do
			member do
				post "subscribe"
				delete "unsubscribe"
			end
			jsonapi_relationships only: %i[index show]
		end
		
		jsonapi_resources :registrations, only: %i[create]
		jsonapi_resource :sessions, only: %i[create destroy]
	end
	# scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
	#
	# 	# Creations
	# 	resources :creations do
	# 		collection do
	# 			get 'discover'
	# 			get 'following'
	# 		end
	# 		resource  :likes,    only: %i[create destroy]
	# 		resources :comments, only: %i[index create destroy]
	# 	end
	#
	#
	#
	# 	# Payments
	# 	resources :payments, only: %i[create]
	# 	post '/stripe/charge'  => 'stripe#charge'
	# 	post '/stripe/webhook' => 'stripe#webhook'
	#
	# 	# Chats and Messages - Not nested under users as it will always be for current users.
	# 	resources :chats, only: %i[index show create destroy] do
	# 		resources :messages, only: %i[create]
	# 	end
	#
	# 	resources :messages, only: %i[create]
	#
	# end
end