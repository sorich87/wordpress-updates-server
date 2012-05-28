Feature: Designer adds a package
  As a theme designer
  I want to add a package
  So that my customers can buy it

  Background:
    Given I signed in to my business account
    When I go to the packages management page
    And I click "Add a package"
    And I see the add package form

  Scenario Outline: Successful addition of a package
    When I fill in "Package Name" with "<name>"
    And I fill in "Package Description" with "<description>"
    And I fill in "Price" with "<price>"
    And I select "<validity>" as "Validity"
    And I choose "<billing>" as "Billing"
    And I select "<themes>" as "Number of Themes"
    And I fill in "Number of Domains" with "<domains>"
    And I click "Save Package"
    Then I should be on the packages management page
    And I should see "<name>"
    And I should see "<description>"
    And I should see "$<price> for <themes>"
    And I should see "Valid for <valid_for> on <output_domains>"
    And I should see "Renewal is <renewal>"

    Scenarios: Successful addition of any package
      | name     | description | price    | validity  | billing                             | themes     | domains | renewal   | output_themes | valid_for | output_domains |
      | Standard | Awesome     | 40.00    | One Year  | One time payment                    | One Theme  | 1       | manual    | one theme | one year   | 1 domain |
      | Free     | The poors   | 0.00     | Lifetime  | One time payment                    | One Theme  | 3       | manual    | one theme | life       | 3 domains |
      | Monthly  | Recurring   | 10.00    | One Month | Subscription with recurring billing | All Themes | 0       | automatic | all themes | one month | unlimited domains |

  Scenario Outline: Unsuccessful addition of a package
    When I fill in "Package Name" with "<name>"
    And I fill in "Package Description" with "<description>"
    And I fill in "Price" with "<price>"
    And I select "<validity>" as "Validity"
    And I choose "<billing>" as "Billing"
    And I select "<themes>" as "Number of Themes"
    And I fill in "Number of Domains" with "<domains>"
    And I click "Save Package"
    Then I should be on the packages management page
    And I should see "Please review the problems below"

    Scenarios: Package name empty
      | name     | description | price    | validity  | billing          | themes     | domains | renewal   |
      |          | Awesome     | 40.00    | One Year  | One time payment | One Theme  | 1       | manual    |

    Scenarios: Package description empty
      | name     | description | price    | validity  | billing          | themes     | domains | renewal   |
      | Free     |             | 0.00     | Lifetime  | One time payment | One Theme  | 3       | manual    |

  @javascript
  Scenario: Cancelling addition of a package
    When I click "Cancel"
    Then I should not see the add package form