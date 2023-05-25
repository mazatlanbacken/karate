Feature: Get Team Position by ID

  Background: Define URL
    Given url urlBase

  @positiveCase
  Scenario: Get Position by ID
    Given path '/api/team/positions'
    And method GET
    Then status 200
    And def position_id = response.data[0].id

    Given path '/api/team/positions/' + position_id
    And method GET
    Then status 200
    And match response.status == true
    And match response.data.id == position_id

  @negativeCase
  Scenario: Get Position with incorrect ID
    Given path '/api/team/positions'
    And method GET
    Then status 200
    And def position_id = response.data[0].id

    Given def incorrect_id = "incorrect_id"
    And path '/api/team/positions/' + incorrect_id
    And method GET
    Then status 200
    And match response.status == true
