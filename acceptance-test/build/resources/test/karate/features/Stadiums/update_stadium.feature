Feature: Create and Delete Stadium

  Background: Define URL
    Given url urlBase
    * def stadiums_data = read('classpath:data/stadiums/stadiums.json')
    * def fn = function(rsp) { return Object.keys(rsp) }
    * def sleep = function(pause){ java.lang.Thread.sleep(pause) }


  @positiveCase
  Scenario: Update and Delete Stadium
    Given path '/api/stadiums'
    And request stadiums_data[0]
    When method POST
    Then status 200
    * print karate.pretty(response)
    And def stadium_id = response.data.id
    * print karate.pretty(stadium_id)

    * eval sleep(2000)
    Given path '/api/stadiums/' + stadium_id
    And request stadiums_data[4]
    And method PATCH
    Then status 200
    * print karate.pretty(response)
    And match response.status == true
    And match response.data[0] == 1

    * eval sleep(2000)
    Given path '/api/stadiums/' + stadium_id
    And method Get
    Then status 200
    And match response.data.text_first_es == "ejemploupdate"

    * eval sleep(2000)
    Given path '/api/stadiums/' + stadium_id
    And method DELETE
    Then status 200
    And match response.status == true
    And match response.data == 1
