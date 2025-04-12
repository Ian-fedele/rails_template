# app/models/user.rb
class User < ApplicationRecord
  # Devise handles authentication
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :songs
  has_many :playlists

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true
end
