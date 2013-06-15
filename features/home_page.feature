Feature: Home Page
  In order to learn about bagels stats
  I want to visit the Home Page
  and have it show me statistics about bagels.

  Scenario: Current bagel owner
    Given a logged-in user
    When the user visits the home page
    Then the current bagel owner should be displayed
