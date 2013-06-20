Feature: Add a bagel
  In order to record a new bagel
  I need to to be able to add it via the UI.

  Scenario: Add a new bagel
    Given a logged-in user
    When the user visits the add-bagel page
    And adds valid bagel info
    And clicks Add Bagel
    Then a new bagel should be added
