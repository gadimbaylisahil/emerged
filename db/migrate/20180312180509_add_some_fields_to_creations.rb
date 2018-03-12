class AddSomeFieldsToCreations < ActiveRecord::Migration[5.1]
  def change
    add_column :creations, :description, :text
    add_column :creations, :license, :text
    add_column :creations, :sensitive_content, :boolean, default: false
    add_column :creations, :disable_comments, :boolean, default: false
  end
end
