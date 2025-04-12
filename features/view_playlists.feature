Feature: Viewing Playlists

As an Amber user
So that I can browse the playlists of the genre
I want to be able to view my playlists and others

Scenario: Viewing my own playlist
Given I have an account
When I go to the my playlists page
Then I should be able to see all my Playlists

Scenario: Viewing one playlist
  Given I have an account with a playlist named "Workout"
  And the playlist contains the song "Eye of the Tiger" by "Survivor"
  When I visit the playlist page for "Workout"
  Then I should see "Workout" as the playlist title
  And I should see the song "Eye of the Tiger" by "Survivor" listed


