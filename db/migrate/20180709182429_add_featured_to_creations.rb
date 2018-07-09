class AddFeaturedToCreations < ActiveRecord::Migration[5.2]
  def change
    add_column :creations, :featured, :boolean, default: false, null: false
  end
end
