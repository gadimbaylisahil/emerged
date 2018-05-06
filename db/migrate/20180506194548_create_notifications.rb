class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :recipient_user_id, null: false
      t.integer :actor_user_id, null: false
      t.datetime :read_at
      t.string :activity_type, null: false
      t.integer :subject_id, null: false
      t.string :subject_type, null: false

      t.timestamps
    end
  end
end
