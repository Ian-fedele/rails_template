Rails.application.routes.draw do
  root "home#index"  # Home page
  
  resources :playlists do
    member do
      post 'add_song/:song_id', to: 'playlists#add_song', as: 'add_song'
    end
  end
  
  resources :genres, only: [:show]
end