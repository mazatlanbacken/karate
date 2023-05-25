Feature: Get Matches  id

  Background: Define URL
    Given url urlBase

  @positiveCase
  Scenario: Get match by ID
    Given path '/api/matches'
    And method GET
    Then status 200
    And def match_id = response.data[0].id

    Given path '/api/matches/' + match_id
    And method GET
    Then status 200
    And match response.status == true
    And match response.data.id == match_id

  @negativeCase
  Scenario: Get match with incorrect ID
    Given path '/api/matches'
    And method GET
    Then status 200
    And def match_id = response.data[0].id

    Given def incorrect_id = "incorrect_id"
    And path '/api/matches/' + incorrect_id
    And method GET
    Then status 200
    And match response.status == true
