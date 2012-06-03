@api
Feature: API client authenticates a site
  As an API client
  I want to authenticate a site
  So that it can use the service

  Scenario: Successful authentication of a site
    Given I have an unconfirmed site
    And I send and accept JSON
    When I send a POST request to the sites endpoint with my email, a domain name and its secret key
    Then a site confirmation message should be sent my email
    When I click on the site confirmation link
    Then I should see a message that my site was confirmed
