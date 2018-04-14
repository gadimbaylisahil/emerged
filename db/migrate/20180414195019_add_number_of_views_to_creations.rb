class AddNumberOfViewsToCreations < ActiveRecord::Migration[5.2]
  def change
    add_column :creations, :number_of_views, :bigint, default: 0, null: false
  end
end
