module V1
	class CreationResource < JSONAPI::Resource
		attribute :title
		attribute :description
		attribute :content
		attribute :sensitive_content
		attribute :disable_comments
		attribute :created_at
		attribute :impressions_count
		
		filter :featured, apply: ->(records, value, _options) {
			records.featured
		}
		filter :today, apply: ->(records, value, _options) {
			records.today
		}
		filter :this_month, apply: ->(records, value, _options) {
			records.this_month
		}
		filter :this_year, apply: ->(records, value, _options) {
			records.this_year
		}
		filter :country, apply: ->(records, value, _options) {
			records.by_location(value)
		}
		filter :subscribed, apply: ->(records, value, _options) {
			records.subscribed(value)
		}
		filter :search, apply: ->(records, value, _options) {
			records.search(value)
		}
		
		
		def total_likes
			@model.get_likes.count
		end
		
		def license
			@model.license.name
		end
		
		def category
			@model.category.name
		end
		
		def total_comments
			@model.comments.count
		end
		
		def liker_ids
			@model.votes_for.up.voters.pluck(:id)
		end
		
		has_one :user
		has_one :category
		has_one :license
		has_many :comments,
		         class_name: 'Comment',
		         foreign_key: 'commentable_id',
		         conditions: ["commentable_type = ?", @model.class.to_s]
		
		before_save do
			@model.user_id = context[:current_user].id if @model.new_record?
		end
	end
end

