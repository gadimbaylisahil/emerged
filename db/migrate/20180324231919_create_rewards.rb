class CreateRewards < ActiveRecord::Migration[5.2]
  def change
    create_table :rewards do |t|
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
