Feature: Designer deletes a package
  As a theme designer
  I want to delete a package
  Because it sucks

  Background:
    Given I signed in to my business account
    And there is one package named "For suckers"
    When I go to the packages management page
    And I click "delete"
    Then I should see an alert box to confirm deletion

  Scenario: Successful deletion of a package
    Then I click "OK"
    And I should be on the packages management page
    And I should not see "For suckers"

  Scenario: Cancelled deletion of a package
    Then I click "Cancel"
    And I should be on the packages management page
    And I should see "For suckers"
