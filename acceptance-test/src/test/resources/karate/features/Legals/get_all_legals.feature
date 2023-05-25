Feature: Get all legals

  Background: Define URL
    Given url urlBase


  @positiveCase
  Scenario: Get all legals
    Given path '/api/legals'
    And method Get
    Then status 200
    And match response.status == true
      * print karate.pretty(response)