class RemoveArtistsAndAdmins < ActiveRecord::Migration[5.2]
  def change
    drop_table :artists
    drop_table :admins
  end
end
