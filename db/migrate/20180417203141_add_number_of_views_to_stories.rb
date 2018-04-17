class AddNumberOfViewsToStories < ActiveRecord::Migration[5.2]
  def change
    add_column :stories, :number_of_views, :bigint, default: 0, null: false
  end
end
