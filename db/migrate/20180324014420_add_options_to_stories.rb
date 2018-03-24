class AddOptionsToStories < ActiveRecord::Migration[5.2]
  def change
    add_column :stories, :disable_comments, :boolean, default: false, null: false
    add_column :stories, :sensitive_content, :boolean, default: false, null: false
  end
end
