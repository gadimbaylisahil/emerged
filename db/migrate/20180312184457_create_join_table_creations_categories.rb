class CreateJoinTableCreationsCategories < ActiveRecord::Migration[5.1]
  def change
    create_join_table :creations, :categories do |t|
      t.index [:creation_id, :category_id]
      t.index [:category_id, :creation_id]
    end
  end
end
