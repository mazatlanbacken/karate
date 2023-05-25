Feature: Get all tshirts

  Background: Define URL
    Given url urlBase

  @positiveCase
    Scenario: Get all tshirts
    Given path '/api/tshirts'
    And method Get
    Then status 200
    And match response.status == true
      And match response.data != null
      * print karate.pretty(response)