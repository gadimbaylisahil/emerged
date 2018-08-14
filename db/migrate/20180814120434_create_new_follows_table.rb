class CreateNewFollowsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :follows, id: :uuid do |t|
      t.references :followable, index: true, polymorphic: true, type: :uuid
      t.references :user, index: true, foreign_key: true, null: false, type: :uuid
      t.timestamps
    end
  end
end
