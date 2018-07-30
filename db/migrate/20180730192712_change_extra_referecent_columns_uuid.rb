require 'webdack/uuid_migration/helpers'

class ChangeExtraReferecentColumnsUuid < ActiveRecord::Migration[5.2]
  def up
	  columns_to_uuid :active_storage_attachments, :record_id, :blob_id
	  columns_to_uuid :activities, :subject_id
	  columns_to_uuid :creations, :license_id
	  columns_to_uuid :follows, :followable_id, :follower_id
	  columns_to_uuid :impressions, :impressionable_id, :user_id
	  columns_to_uuid :notifications, :subject_id, :actor_user_id, :recipient_user_id
	  columns_to_uuid :supports, :supportable_id, :supporter_id, :creator_id
	  columns_to_uuid :votes, :votable_id, :voter_id
  end
	
	def down
		raise ActiveRecord::IrreversibleMigration
	end
end
