class PlaylistsController < ApplicationController
  before_action :authenticate_user!

  def index
    @playlists = current_user.playlists
  end

  def show
    @playlist = Playlist.find(params[:id])
    @songs = Song.where(playlist_id: @playlist.id).includes(:artist)
  end
  
  def new
    @playlist = current_user.playlists.build
  end

  def create
      @playlist = current_user.playlists.new(playlist_params)
    
      if @playlist.save
        redirect_to @playlist, notice: "Playlist created successfully!"
      else
        render :new
      end
  end

  def add_to_playlist
    @song = Song.find(params[:id])
    @playlist = Playlist.find(params[:playlist_id])
  
    @playlist.songs << @song unless @playlist.songs.include?(@song)
    redirect_to playlist_path(@playlist), notice: "Song added to playlist!"
  end
  

  private

  def playlist_params
    params.require(:playlist).permit(:name)
  end
end
