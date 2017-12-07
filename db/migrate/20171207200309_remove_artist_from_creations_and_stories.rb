class RemoveArtistFromCreationsAndStories < ActiveRecord::Migration[5.1]
  def change
    remove_reference :stories, :artist
    remove_reference :creations, :artist
  end
end
