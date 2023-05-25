Feature: Get all Team Positions

  Background: Define URL
    Given url urlBase

  @positiveCase
  Scenario: Get team positions
    Given path '/api/team/positions'
    And method GET
    Then status 200
    And match response.status == true
    And match response.data != null