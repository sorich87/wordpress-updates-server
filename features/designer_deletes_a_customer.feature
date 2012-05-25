Feature: Designer deletes a customer
  As a theme designer
  I want to delete a customer
  Because they give me headaches

  Background:
    Given I signed in to my business account
    And there is one customer named "Samantha Seeley"
    When I go to the customers management page
    And I click delete
    Then I should see an alert box to confirm deletion

  Scenario: Successful deletion of a customer
    Then I confirm deletion in the alert box
    And I should be on the customers management page
    And I should not see "Samantha Seeley"

  Scenario: Cancelled deletion of a customer
    Then I cancel deletion in the alert box
    And I should be on the customers management page
    And I should see "Samantha Seeley"
