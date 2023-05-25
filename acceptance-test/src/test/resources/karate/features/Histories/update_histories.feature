Feature: Update and Delete histories

  Background: Define URL
    Given url urlBase
    * def histories_data = read('classpath:data/histories/request_histories.json')
    * def fn = function(rsp) { return Object.keys(rsp) }
    * def sleep = function(pause){ java.lang.Thread.sleep(pause) }

  @positiveCase
  Scenario: Create, Update and Delete History
    Given path '/api/histories'
    And request histories_data[0]
    When method POST
    Then status 200
    * print karate.pretty(response)
    And def history_id = response.data.id
    * print karate.pretty(history_id)

    * eval sleep(2000)
    Given path '/api/histories/' + history_id
    And request histories_data[2]
    And method PATCH
    Then status 200
    * print karate.pretty(response)
    And match response.status == true
    And match response.data[0] == 1

    * eval sleep(2000)
    Given path '/api/histories/' + history_id
    And method GET
    Then status 200
    And match response.data.text_es == "pruebaupdate"

    * eval sleep(2000)
    Given path '/api/histories/' + history_id
    And method DELETE
    Then status 200
    And match response.status == true
    And match response.data == 1


