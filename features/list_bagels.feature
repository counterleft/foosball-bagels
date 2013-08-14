Feature: List Bagels
  In order to look at bagel history
  I need to be able to view all the bagels ever created

  Scenario: Pagination
    Given a logged-in user
    When the user visits the bagels page
    Then pagination exists for bagels

