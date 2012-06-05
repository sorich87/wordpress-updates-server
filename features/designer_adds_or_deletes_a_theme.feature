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
    And I should see a success message "Theme saved."

  @javascript
  Scenario: Unsuccessful addition of a theme
    When I upload a non-valid theme archive
    Then I should see an error message

  @javascript
  Scenario: Addition of a new version of a theme
    When I have one theme
    And I go to the themes management page
    And I upload a new version of that theme
    Then I should see the new version number
    And I should see a success message "Theme updated."

  @javascript
  Scenario: Deletion of a theme
    When I have one theme
    And I go to the themes management page
    And I delete a theme and confirm deletion
    Then I should be on the themes management page
    And I should not see the theme anymore
