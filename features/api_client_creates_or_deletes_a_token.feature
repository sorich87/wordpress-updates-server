@api
Feature: API client creates or deletes a token
  As an API client
  I want to create and delete a token
  To authenticate my requests

  Background:
    Given I have a confirmed site
    And I send and accept JSON

  Scenario: Successful creation of a token
    When I send a POST request to the tokens endpoint with my email, a domain name and its secret key
    Then the JSON response should contain the token

  Scenario: Successful deletion of a token
    When I send a DELETE request with my token
    Then my token should be reset
