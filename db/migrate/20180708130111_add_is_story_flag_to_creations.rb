class AddIsStoryFlagToCreations < ActiveRecord::Migration[5.2]
  def change
    add_column :creations, :is_story, :boolean, default: false, null: false
  end
end
