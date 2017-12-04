class AddArtistToStories < ActiveRecord::Migration[5.1]
  def change
    add_reference :stories, :artist, index: true, foreign_key: true
  end
end
