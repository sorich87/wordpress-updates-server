Feature: Designer edits company profile
  As a theme designer
  I want to edit my company profile
  So that the information my customers see is up to date

  Background:
    Given I signed in to my business account
    When I go to the edit company profile page
    And the company profile form fields contain my company details
    And I fill in new company details

  Scenario: Successful editing of company profile
    When I click "Save Changes"
    Then I should be on the edit company profile page
    And I should see "Changes saved"
    And the company profile form fields should contain my new company details

  Scenario: Cancelling editing of company profile
    When I click "Cancel"
    Then I should be on the edit company profile page
    And the company profile form fields should contain my company details
