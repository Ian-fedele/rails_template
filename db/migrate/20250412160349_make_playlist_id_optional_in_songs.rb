class MakePlaylistIdOptionalInSongs < ActiveRecord::Migration[6.1]
  def change
    change_column_null :songs, :playlist_id, true
  end
end
