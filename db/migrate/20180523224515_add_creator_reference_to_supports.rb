class AddCreatorReferenceToSupports < ActiveRecord::Migration[5.2]
  def change
    add_reference :supports, :creator, references: :users, index: true
    add_foreign_key :supports, :users, column: :creator_id
  end
end
