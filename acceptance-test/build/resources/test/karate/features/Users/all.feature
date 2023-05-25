Feature: Get all users

  Background: Define URL
    And url urlBase

  @positiveCase
  Scenario: Get all users
    Given path '/api/users'
    And method GET
    Then status 200
    And match response.status == true