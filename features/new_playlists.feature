Feature: Creating a new playlist

As an Amber user
So that I can keep track of my playlist
I want to be able to add a new song to my playlist

Scenario: Successfully adding a song
Given I am on the song page
When I click on add to playlist button
And I click on which playlist to add
Then I should see a confirmation message
And I should see the new song in my playlist

Scenario: Adding a song that already exists in the playlist
Given I am on the song page
When I click on add to playlist button
And I click on which playlist to add
Then I should see a already exists message

Scenario: Creating a new playlist
Given I am on the song page
When I click on add to playlist button
And I click on create new playlist
And I name the playlist
Then I should see a confirmation message
And I should see the new song in the new playlist