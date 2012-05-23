Feature: Manage packages

  So that designers can add, edit and remove packages
  As a designer
  I want to manage my packages

  Scenario: Add a package
    Given a business
    When I visit my package settings page
    And add a package
    And click on "Save changes"
    Then that package should be saved and assigned to my business

  Scenario: Edit a package
    Given a business and a package
    When I visit my package settings page
    And edit the package
    And click on "Save changes"
    Then that package should be updated

  Scenario: Remove a package
    Given a business and a package
    When I visit my package settings page
    And remove the package
    Then that package should be removed
  
