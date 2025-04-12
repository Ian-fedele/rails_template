class AddPlaylistToSongs < ActiveRecord::Migration[8.0]
  def change
    add_reference :songs, :playlist, null: false, foreign_key: true
  end
end
