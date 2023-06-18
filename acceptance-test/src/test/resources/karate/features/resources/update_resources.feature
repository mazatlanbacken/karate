Feature: Update and Delete Resource

  Background: Define URL
    Given url urlBase
    * def fn = function(rsp) { return Object.keys(rsp) }
    * def sleep = function(pause){ java.lang.Thread.sleep(pause) }

  @positiveCase
  Scenario Outline: Create, Update and Delete Resource  - <type>
    Given path '/api/common/resources'
    And request { "type": "<type>", "name_es": "Prueba", "name_en": "Test" }
    When method POST
    Then status 200
    * print karate.pretty(response)
    And def resource_id = response.data.id
    * print karate.pretty(resource_id)

    * eval sleep(2000)
    Given path '/api/common/resources/' + resource_id
    And request { "type": "<type>", "name_es": "PruebaUpdate", "name_en": "Test" }
    And method PATCH
    Then status 200
    * print karate.pretty(response)
    And match response.status == true

    * eval sleep(2000)
    Given path '/api/common/resources/' + resource_id
    And method GET
    Then status 200
    And match response.data.name_es == "PruebaUpdate"

    * eval sleep(2000)
    Given path '/api/common/resources/' + resource_id
    And method DELETE
    Then status 200
    And match response.status == true

    Examples:
      | type            |
      | PREFERRED_TEAMS |
      | ALERTS          |

