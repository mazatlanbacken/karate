Feature: Get t-shirt by ID

  Background: Define URL
    Given url urlBase

  @positiveCase
  Scenario: Get t-shirt by ID
    Given path '/api/tshirts'
    And method Get
    Then status 200
    And def tshirts_id = response.data[0].id

    Given path '/api/tshirts/' + tshirts_id
    And method Get
    Then status 200
    And match response.status == true
    And match response.data.id == tshirts_id

  @negativeCase
  Scenario: Get t-shirt with incorrect ID
    Given path '/api/tshirts'
    And method GET
    Then status 200
    Given def incorrect_id = "incorrect_id"
    And path '/api/tshirts/' + incorrect_id
    And method GET
    Then status 200
    And match response.status == true
