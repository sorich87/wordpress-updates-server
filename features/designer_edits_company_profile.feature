@done
Feature: Designer edits company profile
  As a theme designer
  I want to edit my company profile
  So that the information my customers see is up to date

  Background:
    Given I signed in to my business account
    When I go to the edit company profile page
    And the "Company Name" field contains "Themes For You"
    And the "Email Address" field contains "ythemes@themes.thm"
    And I fill in "Company Name" with "Big Brother Themes"
    And I fill in "Email Address" with "bbthemes@themes.thm"

  Scenario: Successful editing of company profile
    When I click "Save Changes"
    Then I should be on the edit company profile page
    And I should see "Changes saved"
    And the "Company Name" field should contain "Big Brother Themes"
    And the "Email Address" field should contain "bbthemes@themes.thm"

  Scenario: Cancelling editing of company profile
    When I click "Cancel"
    Then I should be on the edit company profile page
    And the "Company Name" field should contain "Themes For You"
    And the "Email Address" field should contain "ythemes@themes.thm"
