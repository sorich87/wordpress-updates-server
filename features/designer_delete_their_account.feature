Feature: Designer deletes their account
  As a designer
  I want to delete my account
  Because I have enough of ThemeMy!

  @javascript
  Scenario: Successful deletion of an account
    Given I signed in to my business account
    When I delete my account
    Then I should see a modal window to confirm deletion
    When I confirm deletion of my account
    Then I should be on the sorry to see you go page
    And all my account data should be deleted
