Feature: Designer changes customer's package
  As a theme designer
  I want to change a customer's package
  To a better one

  Background:
    Given I signed in to my business account
    And there is one package named "Standard"
    And there is one package named "Gold"
    And there is a customer with email "bob.xfc@email.email" and package "Standard"
    When I click "edit"
    Then I should be on the edit customer page
    And I choose "Gold" as "Package"

  Scenario: Successful change of customer's package
    Then I click "Save Changes"
    And I should be on the customer management page
    And I should see "Changes saved"

  Scenario: Cancelled change of customer's package
    Then I click "Cancel"
    And I should be on the customer management page
