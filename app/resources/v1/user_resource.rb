module V1
	class UserResource < JSONAPI::Resource
		# caching
		
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
		attribute :receive_emails_for_follows
		attribute :receive_emails_for_likes
		attribute :receive_emails_from_emerged
		
		has_many :creations
		has_many :notifications, foreign_key: 'recipient_user_id'
		has_many :comments
		has_many :likes
		has_many :follows
		has_many :messages
		has_many :subscriptions
		has_many :chats, through: :subscriptions, class_name: 'Chat'
		has_many :activities
		
		def fetchable_fields
			if !(context[:current_user] == @model)
				super - [:settings, :email]
			else
				super
			end
		end
	
	end
end
