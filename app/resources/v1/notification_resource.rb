module V1
	class NotificationResource < JSONAPI::Resource
		attribute :created_at
		attribute :activity_type
		attribute :from
		attribute :humanized_activity
		attribute :subject_name
		
		has_one :recipient_user, class_name: 'User'
		has_one :actor_user, class_name: 'User'
		
		def from
			@model.actor_user.username
		end
		
		def humanized_activity
			case @model.activity_type
				when 'follow'
					'followed'
				when 'like'
					'liked'
				when 'comment'
					'commented'
			end
		end
		
		def subject_name
			@model.subject.class
		end
		
	end
end