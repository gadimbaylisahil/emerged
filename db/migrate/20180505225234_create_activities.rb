class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.integer :subject_id, index: true, null: false
      t.string :subject_type, index: true, null: false
      t.string :name, null: false
      t.string :direction, null: false
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
