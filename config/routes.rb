Rails.application.routes.draw do
  get "playlists/index"
  get "playlists/show"
  get "playlists/create"
  # Show the selection form
  get "songs/:id/add_to_playlist", to: "songs#select_playlist", as: "select_playlist_for_song"

# Handle the playlist selection form submission
  post "songs/:id/add_to_playlist", to: "songs#add_to_playlist", as: "add_to_playlist_song"

    get "/auth/spotify/callback", to: "sessions#spotify"

  devise_for :users
  root "home#index"

  resources :songs, only: [:index, :show, :create, :new, :destroy] do
    collection do
      get :search
    end

    member do
      post :add_to_playlist
    end
  end

  resources :users do
    resources :playlists
  end

  resources :playlists, only: [:index, :show, :create]
end
