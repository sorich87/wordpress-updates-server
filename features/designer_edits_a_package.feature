Feature: Designer edits a package
  As a theme designer
  I want to edit a package
  To add awesomeness

  Scenario: Successful editing of a package
    Given I signed in to my business account
    And there is one package
    When I go to the edit package page
    Then I see the package details filled in the fields
    When I edit the package
    Then I should be on the packages management page
    And I should see the new package details
    And I should not see the old package details
