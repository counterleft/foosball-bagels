Feature: Players
  In order to view information about Players
  I need to be able to add/find/edit players from the app.

  Scenario: Player Listings
    Given a logged-in user
    When the user visits the players page
    Then the user is shown a list of players
