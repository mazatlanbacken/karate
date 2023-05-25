Feature: Get Stadium by ID

  Background: Define URL
    Given url urlBase

  @positiveCase
  Scenario: Get Stadium by ID
    And path '/api/stadiums', '8b0893d0-e399-11ed-8794-f58efb359f9b'
    When method GET
    Then status 200
    And match response.data.id == '8b0893d0-e399-11ed-8794-f58efb359f9b'
    * print karate.pretty(response)

  @negativeCase
  Scenario: Get stadium with incorrect ID
    And path '/api/stadiums', '8b0893d0-e399-11ed-8794-f58efb359f9'
    When method GET
    Then status 200
    And match response.data == null
    * print karate.pretty(response)