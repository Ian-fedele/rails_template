Feature: Searching for a Song

As an Amber user  
So that I can find music I'm interested in  
I want to be able to search for songs by keyword

Scenario: Successfully finding a song with a keyword  
Given I am on the search page  
When I enter a song keyword into the search bar  
And I click the "Search" button 
Then I should see a list of songs that match the keyword

Scenario: Successfully finding songs by artist name  
Given I am on the search page  
When I enter an artist name into the search bar  
And I click the "Search" button  
Then I should see songs by that artist in the search results

Scenario: No songs found for a search term  
Given I am on the search page  
When I enter a search term that doesn't match any songs  
And I click the "Search" button  
Then I should see a message saying "No songs found"
