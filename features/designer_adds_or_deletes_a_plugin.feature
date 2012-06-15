Feature: Designer adds or deletes a plugin
  As a plugin designer
  I want to add or delete plugin
  Which my customer can download

  Background:
    Given I signed in to my business account
    When I go to the plugins management page

  @javascript
  Scenario: Successful addition of a plugin
    When I upload a new plugin
    Then I should see the new plugin screenshot, name and version number
    And I should see a success message "Plugin saved."

  @javascript
  Scenario: Unsuccessful addition of a plugin
    When I upload a non-valid plugin archive
    Then I should see an error message

  @javascript
  Scenario: Addition of a new version of a plugin
    When I have one plugin
    And I go to the plugins management page
    And I upload a new version of that plugin
    Then I should see the new plugin version number
    And I should see a success message "Plugin updated."

  @javascript
  Scenario: Deletion of a plugin
    When I have one plugin
    And I go to the plugins management page
    And I delete a plugin and confirm deletion
    Then I should be on the plugins management page
    And I should not see the plugin anymore