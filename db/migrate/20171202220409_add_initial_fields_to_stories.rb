class AddInitialFieldsToStories < ActiveRecord::Migration[5.1]
  def change
    add_column :stories, :title, :string
    add_column :stories, :body, :text
    add_column :stories, :status, :integer, allow_null: false
    add_column :stories, :bg_image, :text
  end
end
