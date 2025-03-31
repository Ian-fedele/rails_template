# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :songs
  has_many :playlists

  validates :username, presence: true, uniqueness: true
  validates :email, presence: false, allow_blank: true
end

# app/models/song.rb
class Song < ApplicationRecord
  belongs_to :user
  has_many :playlist_songs
  has_many :playlists, through: :playlist_songs
end

# app/models/playlist.rb
class Playlist < ApplicationRecord
  belongs_to :user
  has_many :playlist_songs
  has_many :songs, through: :playlist_songs
end

# app/models/playlist_song.rb
class PlaylistSong < ApplicationRecord
  belongs_to :playlist
  belongs_to :song
end
