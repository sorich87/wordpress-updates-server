Feature: Designer adds a customer
  As a theme designer
  I want to add a customer
  To provide them happiness

  Background:
    Given I signed in to my business account
    When I go to the add customer page

  Scenario: Successful addition of a customer
    When I add a new customer to my account
    Then I should be on the customer's purchases page
    And I should see a success message

  Scenario: Customer exists
    When I there is a customer in my account
    And I add that customer again
    Then I should see an error message

  Scenario: Cancelled addition of a customer
    When I click "Cancel"
    Then I should be on the customers management page
