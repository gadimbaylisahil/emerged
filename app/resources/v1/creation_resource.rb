module V1
	class CreationResource < JSONAPI::Resource
		attribute :title
		attribute :description
		attribute :content
		attribute :sensitive_content
		attribute :disable_comments
		attribute :created_at
		attribute :impression_count
		
		def total_likes
			@model.get_likes.count
		end
		
		def total_comments
			@model.comments.count
		end
		
		def liker_ids
			@model.votes_for.up.voters.pluck(:id)
		end
		
		has_one :user
	end
end

