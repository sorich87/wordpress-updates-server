Feature: Edit business

  So that businesses can edit their details
  As a designer
  I want to keep my details up to date

  Scenario: Edit business details
    Given a business
    When I edit its details
    And click on "Save changes"
    Then those details should be updated

  Scenario: Cancel editing business details
    Given a business
    When I edit its details
    And click on "Cancel"
    Then the business details should not change