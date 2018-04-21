class AddCategoryToRewards < ActiveRecord::Migration[5.2]
  def change
    add_reference :rewards, :category, foreign_key: true
  end
end
