Feature: Viewing Playlists

As an Amber user
So that I can browse the playlists of the genre
I want to be able to view my playlists and others

Scenario: Viewing my own playlist
Given I have an account
When I go to the my playlists page
Then I should be able to see all my Playlists

Scenario: Viewing one playlist
Given I have an account
When I click on the playlist
Then I should see the collection of songs in the playlist

