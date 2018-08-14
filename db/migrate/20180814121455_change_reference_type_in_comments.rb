class ChangeReferenceTypeInComments < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :commentable_type
    remove_column :comments, :commentable_id
    add_reference :comments, :commentable, type: :uuid, null: false, index: true, polymorphic: true
  end
end
