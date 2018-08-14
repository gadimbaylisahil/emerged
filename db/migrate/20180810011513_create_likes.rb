class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes, id: :uuid do |t|
      t.uuid :creation_id, foreign_key: true, index: true
      t.uuid :user_id, foreign_key: true, index: true

      t.timestamps
    end
  end
end
