Feature: All

  Background: Define URL
    Given url urlBase

  Scenario Outline: Get resources by type - <type_id>

    Given path '/api/common/resources/type/<type_id>'
    And method GET
    Then status 200
    And match response.status == true

    Examples:
      | type_id       |
      | ALERTS        |
      | PREFERRED_TEAMS |



  Scenario Outline: Get resources with incorrect type - <type_id>

    Given path '/api/common/resources/type/<type_id>'
    And method GET
    Then status 200
    And match response.status == true
    And match karate.sizeOf(response.data) == 0


    Examples:
      | type_id          |
      | INVALID_TYPE     |
      | UNKNOWN_TYPE     |
      | INCORRECT_TYPE   |



  Scenario: Get group By Type

    Given path '/api/common/resources/groupByType'
    And method Get
    Then status 200
    And match response.status == true
    * print karate.pretty(response)