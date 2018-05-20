class AddCategoryToProjects < ActiveRecord::Migration[5.2]
  def change
    add_reference :projects, :category, foreign_key: true, index: true
  end
end
