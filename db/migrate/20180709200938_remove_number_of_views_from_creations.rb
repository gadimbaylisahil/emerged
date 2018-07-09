class RemoveNumberOfViewsFromCreations < ActiveRecord::Migration[5.2]
  def change
    remove_column :creations, :number_of_views
  end
end
