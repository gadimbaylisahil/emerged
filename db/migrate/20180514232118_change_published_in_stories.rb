class ChangePublishedInStories < ActiveRecord::Migration[5.2]
  def change
    add_column :stories, :published, :boolean, default: false, null: false
  end
end
