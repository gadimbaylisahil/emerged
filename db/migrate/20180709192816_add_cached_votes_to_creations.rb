class AddCachedVotesToCreations < ActiveRecord::Migration[5.2]
  def up
    change_table :creations do |t|
      t.integer :cached_votes_up, default: 0
    end
    Creation.find_each(&:update_cached_votes)
  end
  
	def down
    remove_column :creations, :cached_votes_up
  end
end