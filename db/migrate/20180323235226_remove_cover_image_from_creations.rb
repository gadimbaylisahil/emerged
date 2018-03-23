class RemoveCoverImageFromCreations < ActiveRecord::Migration[5.2]
  def change
    remove_column :creations, :cover_image
  end
end
