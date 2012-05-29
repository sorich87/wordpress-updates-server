Feature: Visitor creates an account
  As a visitor
  I want to create an account
  So that I can use ThemeMy! tools

  Background:
    Given I am a visitor without an account
    And I am on the registration page

  Scenario: Successful account creation
    When I fill in and submit the registration form
    Then I should see a registration success message
    When I confirm my account
    Then I should see a confirmation success message

  Scenario: One field is empty
    When I incorrectly fill in the registration form
    Then I should see an error message
