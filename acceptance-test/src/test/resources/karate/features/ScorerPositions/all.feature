Feature: Get all Scorer Positions

  Background: Define URL
    Given url urlBase

  @positiveCase
  Scenario: Get Scorer Positions
    Given path '/api/scorer/positions'
    And method GET
    Then status 200
    And match response.status == true
    And match response.data != null