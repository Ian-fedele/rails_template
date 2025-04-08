# Setup steps for testing song and playlist interactions

# Given step for accessing song and playlist pages
Given('I am on the search page') do
  visit search_songs_path # Navigate to the song search page need to find actual route
end

Given('I have a song in my playlist') do
  # Create a playlist and song, then add the song to the playlist
  @playlist = Playlist.create!(name: "Chill Vibes", user: User.first)
  @song = Song.create!(title: "Test Song", artist: "Test Artist")
  @playlist.songs << @song
end

Given('I am on the song page') do
  # Create a new song and visit its individual page
  @song = Song.create!(title: "New Song", artist: "Artist")
  visit song_path(@song)
end

Given('I have an account') do
  # Create a user account and log them in
  @user = User.create!(email: 'user@example.com', password: 'password')
  login_as(@user, scope: :user) # Log in with the created user
end

Given('I am on the song details page') do
  # Visit the song details page for the song in the playlist
  visit playlist_song_path(@playlist, @song)
end

# Search feature scenarios
When('I enter a song keyword into the search bar') do
  fill_in 'search', with: 'love' # Enter a song keyword
end

When('I enter an artist name into the search bar') do
  fill_in 'search', with: 'Adele' # Enter an artist name
end

When("I enter a search term that doesn't match any songs") do
  fill_in 'search', with: 'xyz123nomatch' # Enter a non-matching term
end

When('I click the search button') do
  click_button 'Search' # Click the search button to execute search
end

Then('I should see a list of songs that match the keyword') do
  expect(page).to have_css('.song-result') # Check if the song results are displayed
end

Then('I should see songs by that artist in the search results') do
  expect(page).to have_content('Adele') # Ensure songs by the artist are displayed
end

Then('I should see a message saying "No songs found"') do
  expect(page).to have_content('No songs found') # Ensure no results message appears
end

# Deleting a song from the playlist
When('I click the delete button') do
  click_button 'Delete Song' # Click the delete button for the song
end

When('I confirm the deletion') do
  # Accept the JS confirmation alert for deletion (if needed)
  page.driver.browser.switch_to.alert.accept rescue nil
end

Then('I should see a confirmation deletion message') do
  expect(page).to have_content('Song was successfully deleted') # Ensure confirmation message
end

Then('the song should be removed from my playlist') do
  visit playlist_path(@playlist) # Visit playlist page
  expect(page).not_to have_content('Test Song') # Ensure song is no longer in the playlist
end

When('I cancel the deletion') do
  # Dismiss the JS confirmation dialog to cancel deletion
  page.driver.browser.switch_to.alert.dismiss rescue nil
end

Then('the song should remain in my playlist') do
  visit playlist_path(@playlist) # Visit the playlist again
  expect(page).to have_content('Test Song') # Ensure the song remains
end

# New Playlist Feature (adding song to playlist)
When('I click on add to playlist button') do
  click_button 'Add to Playlist' # Click the button to add song to playlist
end

When('I click on which playlist to add') do
  @playlist = Playlist.create!(name: "My Playlist", user: User.first) # Create a playlist
  choose(@playlist.name) # Choose the playlist from the list
  click_button 'Confirm Add' # Confirm the song addition to the playlist
end

Then('I should see a confirmation message') do
  expect(page).to have_content('Song added to playlist') # Ensure confirmation message appears
end

Then('I should see the new song in my playlist') do
  visit playlist_path(@playlist) # Visit the playlist page
  expect(page).to have_content(@song.title) # Ensure the song is in the playlist
end

Then('I should see a already exists message') do
  expect(page).to have_content('This song is already in the playlist') # Handle already added song
end

When('I click on create new playlist') do
  click_link 'Create New Playlist' # Click the link to create a new playlist
end

When('I name the playlist') do
  fill_in 'Playlist Name', with: 'Fresh Vibes' # Name the new playlist
  click_button 'Create Playlist' # Submit the creation of the new playlist
  @playlist = Playlist.find_by(name: 'Fresh Vibes') # Find the newly created playlist
end

Then('I should see the new song in the new playlist') do
  visit playlist_path(@playlist) # Visit the new playlist page
  expect(page).to have_content(@song.title) # Ensure the song is in the new playlist
end

# Viewing Playlists Feature
When('I go to the my playlists page') do
  visit user_playlists_path(@user) # Visit the user's playlists page
end

Then('I should be able to see all my Playlists') do
  expect(page).to have_content('My Playlists') # Ensure the playlists section is visible
  expect(page).to have_css('.playlist', count: @user.playlists.count) # Ensure the correct number of playlists
end

When('I click on the playlist') do
  @playlist = @user.playlists.first # Select the first playlist (adjust as needed)
  click_link @playlist.name # Click the playlist name to view it
end

Then('I should see the collection of songs in the playlist') do
  @playlist.songs.each do |song| # Loop through each song in the playlist
    expect(page).to have_content(song.title) # Ensure the song titles are shown on the page
  end
end
