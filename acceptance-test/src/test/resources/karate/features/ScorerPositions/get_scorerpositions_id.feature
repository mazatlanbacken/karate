Feature: Get Scorer Positionsby ID

  Background: Define URL
    Given url urlBase

  @positiveCase
  Scenario: Get Scorer Positionsby ID
    Given path '/api/scorer/positions'
    And method GET
    Then status 200
    And def scorer_id = response.data[0].id

    Given path '/api/scorer/positions/' + scorer_id
    And method GET
    Then status 200
    And match response.status == true
    And match response.data.id == scorer_id

  @negativeCase
  Scenario: Get Scorer Positions with incorrect ID
    Given path '/api/scorer/positions'
    And method GET
    Then status 200
    And def scorer_id = response.data[0].id

    Given def incorrect_id = "incorrect_id"
    And path '/api/scorer/positions/' + incorrect_id
    And method GET
    Then status 200
    And match response.status == true
