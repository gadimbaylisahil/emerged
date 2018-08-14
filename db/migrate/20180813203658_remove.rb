class Remove < ActiveRecord::Migration[5.2]
  def change
    remove_column :creations, :cached_votes_up
  end
end
