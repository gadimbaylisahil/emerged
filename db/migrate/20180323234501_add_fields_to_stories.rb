class AddFieldsToStories < ActiveRecord::Migration[5.2]
  def change
    remove_column :stories, :body
    remove_column :stories, :bg_image
    remove_column :stories, :status
    add_column :stories, :content, :text
    add_reference :stories, :user, index: true, foreign_key: true
  end
end
