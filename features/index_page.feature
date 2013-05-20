Feature: Index Page
  In order to learn about bagels stats
  I want to visit the Index Page
  and have it show me statistics about bagels.

  Scenario: Current bagel owner
    Given a logged-in user
    When the user visits the index page
    Then the current bagel owner should be displayed
