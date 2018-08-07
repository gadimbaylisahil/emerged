module V1
	class UserResource < JSONAPI::Resource
		attribute :first_name
		attribute :last_name
		attribute :display_name
		attribute :title
		attribute :about_me
		attribute :username
		attribute :company
		attribute :city
		attribute :country
		attribute :website_url
		attribute :email
		attribute :settings
		
		filter :email
		
		has_many :creations
		has_many :notifications, foreign_key: :recipient_id
		has_many :comments
		has_many :messages
		has_many :subscriptions
		has_many :chats, through: :subscriptions, class_name: 'Chat'
		has_many :activities
		
		def following_ids
			@model.following_by_type('User').pluck(:id)
		end
		
		def subscription_ids
			user.following_by_type('Category').pluck(:id)
		end
		
		def fetchable_fields
			if !(context[:current_user] == @model)
				super - [:settings, :email]
			else
				super
			end
		end
	
	end
end
