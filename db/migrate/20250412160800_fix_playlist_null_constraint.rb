class FixPlaylistNullConstraint < ActiveRecord::Migration[6.1]
  def up
    change_column_null :songs, :playlist_id, true
  end

  def down
    change_column_null :songs, :playlist_id, false
  end
end
