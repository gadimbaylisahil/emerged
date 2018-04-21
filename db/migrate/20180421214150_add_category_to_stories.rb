class AddCategoryToStories < ActiveRecord::Migration[5.2]
  def change
    add_reference :stories, :category, foreign_key: true
  end
end
