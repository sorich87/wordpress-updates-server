Feature: Designer deletes a customer
  As a theme designer
  I want to delete a customer
  Because they give me headaches

  Background:
    Given I signed in to my business account
    And there is one customer with email "samantha@seeley.com"
    When I go to the customers management page

  @javascript
  Scenario: Successful deletion of a customer
    Then I click on delete and "accept" the confirmation
    And I should be on the customers management page
    And I should not see "samantha@seeley.com"

  @javascript
  Scenario: Cancelled deletion of a customer
    Then I click on delete and "decline" the confirmation
    And I should be on the customers management page
    And I should see "samantha@seeley.com"
