class AddUserToCreations2 < ActiveRecord::Migration[5.1]
  def change
    add_reference :creations, :user, foreign_key: true, index: true
  end
end
