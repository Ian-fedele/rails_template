# app/controllers/home_controller.rb
class HomeController < ApplicationController
  def index
    if user_signed_in?
      @songs = current_user.songs
      @playlists = current_user.playlists
    end
  end
end
