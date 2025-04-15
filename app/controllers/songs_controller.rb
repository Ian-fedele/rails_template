class SongsController < ApplicationController
  def show
    @song = Song.find(params[:id])
  end

  def search
    if params[:search].present?
      query = params[:search].downcase
    
      # Search Spotify for tracks
      @spotify_songs = RSpotify::Track.search(query, limit: 5)
      
      # If no results are found, set @spotify_songs to an empty array
      @spotify_songs = [] if @spotify_songs.empty?
    else
      flash[:alert] = "Please enter a search term."
    end
  end  
  
  def select_playlist
    @song = Song.find(params[:id])
  end

  def add_to_playlist
    unless user_signed_in?
      redirect_to new_user_session_path, alert: "Please sign in first."
      return
    end

    @song = Song.find(params[:id])
    playlist = current_user.playlists.find_by(id: params[:playlist_id])

    if playlist.nil?
      redirect_to select_playlist_for_song_path(@song), alert: "Playlist not found."
    elsif playlist.songs.include?(@song)
      redirect_to playlist_path(playlist), alert: "This song is already in the playlist."
    else
      playlist.songs << @song
      redirect_to playlist_path(playlist), notice: "Song added to playlist"
    end
  end

  def new
    @song = Song.new
  end

  def index
    @songs = Song.all
  end

  def create
    @song = Song.new(song_params)
    @song.user = current_user

    if @song.save
      redirect_to @song, notice: "Song was successfully created."
    else
      flash.now[:alert] = "There was an error creating the song."
      render :new
    end
  end

  def destroy
    @song = Song.find(params[:id])
    playlist = @song.playlist
    @song.destroy
    respond_to do |format|
      format.html { redirect_to playlist_path(playlist), notice: "Song was successfully deleted." }
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("song-list",
                                                  partial: "playlists/song_list",
                                                  locals: { songs: playlist.songs.reorder(nil) })
      end
    end
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_id, :playlist_id)
  end
end
