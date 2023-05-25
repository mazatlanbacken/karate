Feature: Get all stadiums

  Background: Define URL
    Given url urlBase

  @positiveCase
    Scenario: Get all stadiums
    Given path '/api/stadiums'
    And method Get
    Then status 200
    And match response.status == true
      * print karate.pretty(response)