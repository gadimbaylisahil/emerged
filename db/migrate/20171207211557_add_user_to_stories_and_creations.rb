class AddUserToStoriesAndCreations < ActiveRecord::Migration[5.1]
  def change
    add_reference :stories, :user, foreign_key: true, index: true
    add_reference :creations, :user, foreign_key: true, index: true
  end
end
