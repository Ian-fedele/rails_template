class Song < ApplicationRecord
  belongs_to :artist
  belongs_to :user
  belongs_to :playlist, optional: true
end
