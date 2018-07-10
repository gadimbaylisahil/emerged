class AddCachedCommentsCountToCreations < ActiveRecord::Migration[5.2]
  def up
    add_column :creations, :cached_comments_count, :integer, default: 0, null: false
    Creation.all.each do |creation|
      creation.cached_comments_count = creation.comments.count
      creation.save!
    end
  end
  
  def down
    remove_column :creations, :cached_comments_count
  end
end
