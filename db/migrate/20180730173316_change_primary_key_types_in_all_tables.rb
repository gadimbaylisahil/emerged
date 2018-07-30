require 'webdack/uuid_migration/helpers'

class ChangePrimaryKeyTypesInAllTables < ActiveRecord::Migration[5.2]
  def up
	  tables = ActiveRecord::Base.connection.tables
	  tables.each do |table|
		  next if ['schema_migrations', 'ar_internal_metadata'].include?(table)
		  primary_key_and_all_references_to_uuid table.to_sym
	  end
  end
	
	def down
		raise ActiveRecord::IrreversibleMigration
	end
end
