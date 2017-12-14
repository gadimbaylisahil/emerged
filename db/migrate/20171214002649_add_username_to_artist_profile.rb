class AddUsernameToArtistProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :artist_profiles, :username, :string
  end
end
