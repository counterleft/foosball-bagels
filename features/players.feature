Feature: Players
  In order to view information about Players
  I need to be able to add/find/edit players from the app.

  Scenario: Player Listings
    Given a logged-in user
    When the user visits the players page
    Then the user is shown a list of players

  Scenario: Player Show Page
    Given a logged-in user
    When the user visits the players page
    And visits a player's show page
    Then the user is shown that player's show page

  Scenario: Paginating Player's Bagels
    Given a logged-in user
    When the user visits the players page
    And visits a player's show page
    Then pagination exists for bagels

