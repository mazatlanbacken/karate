Feature: Update and Delete legal

  Background: Define URL
    Given url urlBase
    * def legals_data = read('classpath:data/Legals/request_legal.json')
    * def fn = function(rsp) { return Object.keys(rsp) }
    * def sleep = function(pause){ java.lang.Thread.sleep(pause) }

  @positiveCase
  Scenario: Update and Delete Legal
    Given path '/api/legals'
    And request legals_data[0]
    When method POST
    Then status 200
    * print karate.pretty(response)
    And def legal_id = response.data.id
    * print karate.pretty(legal_id)

    * eval sleep(2000)
    Given path '/api/legals/' + legal_id
    And request legals_data[1]
    And method PATCH
    Then status 200
    * print karate.pretty(response)
    And match response.status == true

    * eval sleep(2000)
    Given path '/api/legals/' + legal_id
    And method GET
    Then status 200
    And match response.data.title_es == "ejemploupdate"

    * eval sleep(2000)
    Given path '/api/legals/' + legal_id
    And method DELETE
    Then status 200
    And match response.status == true


