Feature: Get all common resources

  Background: Define URL
    Given url urlBase

  @positiveCase
    Scenario: Get all common resources
    Given path '/api/common/resources'
    And method Get
    Then status 200
    And match response.status == true
      And match response.data != null
      * print karate.pretty(response)