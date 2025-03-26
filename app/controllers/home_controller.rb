class HomeController < ApplicationController
  def index
    @playlists = Playlist.limit(5).order(created_at: :desc)
    @songs = Song.limit(5).order(created_at: :desc)
  end
end