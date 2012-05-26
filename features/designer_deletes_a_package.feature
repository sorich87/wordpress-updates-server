@javascript, @done
Feature: Designer deletes a package
  As a theme designer
  I want to delete a package
  Because it sucks

  Background:
    Given I signed in to my business account
    And there is one package named "For suckers"
    When I go to the packages management page

  Scenario: Successful deletion of a package
    Then I click "Delete" and "accept" the confirmation
    And I should be on the packages management page
    And I should not see "For suckers"

  Scenario: Cancelled deletion of a package
    Then I click "Delete" and "decline" the confirmation
    And I should be on the packages management page
    And I should see "For suckers"
