Feature: Get histories id

  Background: Define URL
    Given url urlBase

  @positiveCase
  Scenario: Get histories id
    Given path '/api/histories'
    And method Get
    Then status 200
    And def histories_id = response.data[0].id

    Given path '/api/histories/' + histories_id
    And method Get
    Then status 200
    And match response.status == true
    And match response.data.id == histories_id

  @negativeCase
  Scenario: Get histories with incorrect ID
    Given path '/api/histories'
    And method GET
    Then status 200
    And def histories_id  = response.data[0].id

    Given def incorrect_id = "incorrect_id"
    And path '/api/histories/' + incorrect_id
    And method GET
    Then status 200
    And match response.status == true
    And match response.data == null
