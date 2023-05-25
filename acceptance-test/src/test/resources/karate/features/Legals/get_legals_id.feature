Feature: Get legals id

  Background: Define URL
    Given url urlBase

  @positiveCase
  Scenario: Get legals id
    Given path '/api/legals'
    And method Get
    Then status 200
    And def legals_id = response.data[0].id

    Given path '/api/legals/' + legals_id
    And method Get
    Then status 200
    And match response.status == true
    And match response.data.id == legals_id

  @negativeCase
  Scenario: Get legal with incorrect ID
    Given path '/api/legals'
    And method GET
    Then status 200
    And def legals_id = response.data[0].id

    Given def incorrect_id = "incorrect_id"
    And path '/api/legals/' + incorrect_id
    And method GET
    Then status 200
    And match response.status == true
