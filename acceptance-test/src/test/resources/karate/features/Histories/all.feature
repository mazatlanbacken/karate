Feature: Get all histories

  Background: Define URL
    Given url urlBase

  @positiveCase
    Scenario: Get all histories
    Given path '/api/histories'
    And method Get
    Then status 200
    And match response.status == true
      * print karate.pretty(response)