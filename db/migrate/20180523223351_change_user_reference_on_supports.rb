class ChangeUserReferenceOnSupports < ActiveRecord::Migration[5.2]
  def change
    remove_reference :supports, :user
    add_reference :supports, :supporter, references: :users, index: true
    add_foreign_key :supports, :users, column: :supporter_id
  end
end
