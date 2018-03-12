class CreateCategorizationTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :categories, :creations, table_name: :categorizations do |t|
      t.index :category_id
      t.index :creation_id
    end
  end
end
