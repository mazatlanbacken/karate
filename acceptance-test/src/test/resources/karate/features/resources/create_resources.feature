Feature: Create and Delete resources
  Background:
    * url urlBase
    * def response_resources_data = read('classpath:data/resources/response_resources.json')
    * def fn = function(rsp) { return Object.keys(rsp) }

  @positiveCase
  Scenario Outline: Create and Delete Resource - <type>
    Given url urlBase
    And path '/api/common/resources'
    And request { "type": "<type>", "name_es": "Prueba", "name_en": "Test" }
    And method POST
    When status 200
    Then match response.status == true
    And def resourceId = response.data.id

    Given def deletePath = '/api/common/resources/' + resourceId
    And path deletePath
    And method DELETE
    When status 200
    Then match response.status == true

    Examples:
      | type            |
      | PREFERRED_TEAMS |
      | ALERTS          |



  @positiveCase
  Scenario: Validate resources response structure
    Given path '/api/common/resources'
    And request { "type": "PREFERRED_TEAMS", "name_es": "Prueba", "name_en": "Test" }
    When method POST
    Then status 200
    And match fn(response_resources_data.data) contains ["id","type","name_es","name_en","updated_at","created_at"]

    And def resourceId = response.data.id
    Given def deletePath = '/api/common/resources/' + resourceId
    And path deletePath
    And method DELETE
    When status 200
    Then match response.status == true




