Feature: Deleting a Song

As an Amber user
So that I can remove a song I no longer need
I want to be able to delete a song from my playlist

Scenario: Successfully deleting a song
Given I have a song in my playlist
And I am on the song details page
When I click the delete button
And I confirm the deletion
Then I should see a confirmation deletion message
And the song should be removed from my playlist

Scenario: Canceling a song deletion
Given I have a song in my playlist
And I am on the song details page
When I click the deletion button
And I cancel the deletion
Then the song should remain in my playlist