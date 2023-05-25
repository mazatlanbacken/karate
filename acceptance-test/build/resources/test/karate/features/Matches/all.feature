Feature: Get all Matches

  Background: Define URL
    Given url urlBase

  @positiveCase
  Scenario: Get matches with pagination
    Given path '/api/matches'
    And param page = 1
    And param pageSize = 10
    And method GET
    Then status 200
    And match response.status == true
    And match response.data != null