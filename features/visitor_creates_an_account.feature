Feature: Visitor creates an account
  As a visitor
  I want to create an account
  So that I can use ThemeMy! tools

  Background:
    Given I am a visitor without an account
    And the following account exists:
      | business_name | account_name | first_name | last_name | email            | password |
      | Venom Themes  | venom        | Eddie      | Brock     | eddie@venom.thm  | 3E#r4$   |
    When I go to the registration page

  @wip
  Scenario: Successful account creation
    When I fill in "Business Name" with "Spider Themes"
    And I fill in "Account Name" with "spider"
    And I fill in "First Name" with "Peter"
    And I fill in "Last Name" with "Parker"
    And I fill in "Email Address" with "peter@spider.thm"
    And I fill in "Password" with "1Q!w2@"
    And I fill in "Password Again" with "1Q!w2@"
    And I click "Register"
    Then I should see "You will receive an email with instructions about how to confirm your account in a few minutes."
    And I follow the "Confirm my account" link in the last sent email
    Then I should see "Your account was successfully confirmed. You are now signed in."

  @wip
  Scenario Outline: Failed account creation
    When I fill in "Business Name" with "<business_name>"
    And I fill in "Account Name" with "<account_name>"
    And I fill in "First Name" with "<first_name>"
    And I fill in "Last Name" with "<last_name>"
    And I fill in "Email Address" with "<email_address>"
    And I fill in "Password" with "<password>"
    And I fill in "Password Again" with "<password_again>"
    And I click "Register"
    Then I should see "Please review the problems below:"

    Scenarios: One required field empty
      | business_name | account_name | first_name | last_name | email            | password | password_confirmation |
      |               | spider       | Peter      | Parker    | peter@spider.thm | 1Q!w2@   | 1Q!w2@                |
      | Spider Themes |              | Peter      | Parker    | peter@spider.thm | 1Q!w2@   | 1Q!w2@                |
      | Spider Themes | spider       | Peter      | Parker    |                  | 1Q!w2@   | 1Q!w2@                |
      | Spider Themes | spider       | Peter      | Parker    | peter@spider.thm |          | 1Q!w2@                |
      | Spider Themes | spider       | Peter      | Parker    | peter@spider.thm | 1Q!w2@   |                       |

    Scenarios: One unique field exists
      | business_name | account_name | first_name | last_name | email            | password | password_confirmation |
      | Spider Themes | venom        | Peter      | Parker    | peter@spider.thm | 1Q!w2@   | 1Q!w2@                |
      | Spider Themes | spider       | Peter      | Parker    | eddie@venom.thm  | 1Q!w2@   | 1Q!w2@                |

    Scenarios: Password doesn't match password confirmation
      | business_name | account_name | first_name | last_name | email            | password | password_confirmation |
      | Spider Themes | spider       | Peter      | Parker    | peter@spider.thm | 1Q!w2@   | 1Q!w2#                |
