@done
Feature: Designer edits a package
  As a theme designer
  I want to edit a package
  To add awesomeness

  Background:
    Given I signed in to my business account
    And there is one package

  Scenario Outline: Successful editing of a package
    When I go to the packages management page
    And I click "Edit"
    Then I should be on the edit package page
    And I see the edit package form
    And I see the package information filled in the fields
    Then I fill in "Package Name" with "<name>"
    And I fill in "Package Description" with "<description>"
    And I fill in "Price" with "<price>"
    And I select "<validity>" as "Validity"
    And I choose "<billing>" as "Billing"
    And I select "<themes>" as "Number of Themes"
    And I fill in "Number of Domains" with "<domains>"
    And I click "Save Package"
    Then I should be on the packages management page
    And I should see "Package saved"
    And I should see "<name>"
    And I should see "<description>"
    And I should see "$<price> for <themes>"
    And I should see "Valid for <valid_for> on <output_domains>"
    And I should see "Renewal is <renewal>"
    And I should not see the old package information


    Scenarios: Successful edition of any package
      | name     | description | price | validity  | billing                                | themes     | domains | renewal   | output_themes | valid_for | output_domains |
      | Standard | Awesome     | 40.00    | One Year  | One time payment                    | One Theme  | 1       | manual    | one theme | one year | 1 domain |
      | Free     | The poors   | 0.00     | Lifetime  | One time payment                    | One Theme  | 3       | manual    | one theme | life | 3 domains |
      | Monthly  | Recurring   | 10.00    | One Month | Subscription with recurring billing | All Themes | 0       | automatic | all themes | one month | unlimited domains |

    Scenario Outline: Unsuccessful editing of a package
      When I go to the packages management page
      And I click "Edit"
      Then I should be on the edit package page
      And I see the edit package form
      And I see the package information filled in the fields
      Then I fill in "Package Name" with "<name>"
      And I fill in "Package Description" with "<description>"
      And I fill in "Price" with "<price>"
      And I select "<validity>" as "Validity"
      And I choose "<billing>" as "Billing"
      And I select "<themes>" as "Number of Themes"
      And I fill in "Number of Domains" with "<domains>"
      And I click "Save Package"
      Then I should be on the re-edit package page
      And I should see "Please review the problems below"
      And the "Package Name" field should contain "<name>"
      And the "Package Description" field should contain "<description>"
      And the "Price" field should contain "<price>"
      And "<validity>" should be selected for the "Validity" field
      And "<billing>" should be chosen for the "Billing" field
      And "<themes>" should be selected for the "Number of Themes" field
      And the "Number of Domains" field should contain "<domains>"

      Scenarios: Package name empty
        | name     | description | price | validity     | billing          | themes     | domains | renewal   |
        |          | Awesome     | 40.00    | One Year  | One time payment | One Theme  | 1       | manual    |

      Scenarios: Package description empty
        | name     | description | price | validity     | billing          | themes     | domains | renewal   |
        | Free     |             | 0.00     | Lifetime  | One time payment | One Theme  | 3       | manual    |

    Scenario: Cancelling editing of a package
      When I go to the packages management page
      And I click "Edit"
      Then I should be on the edit package page
      And I see the edit package form
      Then I click "Cancel"
      Then I should be on the packages management page
