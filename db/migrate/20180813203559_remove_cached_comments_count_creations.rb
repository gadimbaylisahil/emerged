class RemoveCachedCommentsCountCreations < ActiveRecord::Migration[5.2]
  def change
    remove_column :creations, :cached_comments_count
  end
end
