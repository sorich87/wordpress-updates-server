@wip
Feature: Designer adds or deletes a theme
  As a theme designer
  I want to add or delete theme
  Which my customer can download

  Background:
    Given I signed in to my business account
    When I go to the themes management page

  @javascript
  Scenario: Successful addition of a theme
    When I upload a new theme
    Then I should see the new theme screenshot, name and version number
    And I should see a success message

  @javascript
  Scenario: Unsuccessful addition of a theme
    When I upload a non-valid theme archive
    Then I should see an error message

  @javascript
  Scenario: Addition of a new version of a theme
    When I have one theme
    And I upload a new version of that theme
    Then I should see the new version number
    And I should see a success message

  @javascript
  Scenario: Deletion of a theme
    When I delete a theme
    And I confirm deletion
    Then I should not see the theme screenshot
    And I should not see the theme name
