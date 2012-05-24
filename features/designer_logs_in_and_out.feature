Feature: Designer logs in and out
  As a designer
  I want to log in to and out of my account
  So that I can use ThemeMy! tools

  Scenario: Successful login
    Given I am a confirmed user
    When I sign in
    Then I should be on the themes listing page
    And I should see "Signed in successfully."

  Scenario: Successful logout
    Given I am signed in
    And I follow "Logout"
    Then I should be on the login page
    And I should see "Signed out successfully."
