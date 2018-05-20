class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.references :user, foreign_key: true, index: true
      t.string :title, default: '', null: false
      t.text :description, default: '', null: false
      t.text :content, default: '', null: false

      t.timestamps
    end
  end
end
