Feature: Get all team members

  Background: Define URL
    Given url urlBase

  @positiveCase
    Scenario: Get all team members

      Given path '/api/team/members'
    And method Get
    Then status 200
    And match response.status == true
      * print karate.pretty(response)