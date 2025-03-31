Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  resources :songs, only: [:index]
  resources :playlists, only: [:index]
end
