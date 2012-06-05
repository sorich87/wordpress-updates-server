Feature: Designer adds a package
  As a theme designer
  I want to add a package
  So that my customers can buy it

  @javascript
  Scenario: Successful addition of a package
    Given I signed in to my business account
    When I go to the packages management page
    And I add a package
    Then I should be on the packages management page
    And I should see the package details
