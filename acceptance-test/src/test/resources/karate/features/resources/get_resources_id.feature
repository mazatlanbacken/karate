Feature: Get resources  id

  Background: Define URL
    Given url urlBase

  @positiveCase
  Scenario: Get resources  id
    Given path '/api/common/resources'
    And method Get
    Then status 200
    And def resources_id = response.data[0].id

    Given path '/api/common/resources/' + resources_id
    And method Get
    Then status 200
    And match response.status == true
    And match response.data.id == resources_id

  @negativeCase
  Scenario: Get resources  with incorrect ID
    Given path '/api/legals'
    And method GET
    Then status 200
    And def resources_id = response.data[0].id

    Given def incorrect_id = "incorrect_id"
    And path '/api/legals/' + incorrect_id
    And method GET
    Then status 200
    And match response.status == true
