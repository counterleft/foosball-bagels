Feature: Sign In
  In order to access the site
  I need have to sign in with the master password.

  Scenario: Sign In Page
    Given an unlogged-in user
    When the user visits the sign_in page
    Then the user must login

  Scenario: Failed Sign In
    Given an unlogged-in user
    When the user visits the sign_in page
    And the user enters an incorrect password
    Then an error is shown
