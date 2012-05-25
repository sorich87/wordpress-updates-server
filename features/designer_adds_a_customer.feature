Feature: Designer adds a customer
  As a theme designer
  I want to add a customer
  To provide them happiness

  Background:
    Given I signed in to my business account
    And there is a package named "Standard"
    And there is a package named "Developer"
    And there is a customer with email "tom.sawyer@somemail.email"
    When I go to the customers management page
    And I click "New Customer"
    Then I should be on the add customer page

  Scenario: Successful addition of a customer
    Then I fill in "First Name" with "Drew"
    And I fill in "Last Name" with "Allison"
    And I fill in "Email" with "drew.allis@myemail.email"
    #And I choose "Developer" as "Package"
    And I click "Save Customer"
    Then I should be on the customers management page
    And I should see "Customer saved"
    And I should see "Drew Allison" in the column "Name"
    And I should see "drew.allis@myemail.email" in the column "Email"
    #And I should see "Developer" in the column "Package"

  Scenario: Customer exists
    Then I fill in "First Name" with "Tom"
    And I fill in "Last Name" with "Sawyer"
    And I fill in "Email" with "tom.sawyer@somemail.email"
    #And I choose "Standard" as "Package"
    And I click "Save Customer"
    Then I should be on the customers management page
    And I should see "Please review the problems below"
    And the "First Name" field should contain "Tom"
    And the "Last Name" field should contain "Sawyer"
    And the "Email" field should contain "tom.sawyer@somemail.email"
    #And "Standard" should be selected as "Package"

  Scenario: Cancelled addition of a customer
    Then I click "Cancel"
    And I should be on the customers management page
