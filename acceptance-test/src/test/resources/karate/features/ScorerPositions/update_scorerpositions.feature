Feature: update  Team Positions

  Background: Define URL
    Given url urlBase
    * def fn = function(rsp) { return Object.keys(rsp) }
    * def sleep = function(pause){ java.lang.Thread.sleep(pause) }
  @positiveCase
  Scenario: Update and Get Positions
    Given path '/api/scorer/positions'
    And method GET
    Then status 200
    And def scorer_id = response.data[0].id

    * eval sleep(2000)
    Given path '/api/scorer/positions/' + scorer_id
    And request { "position": 20}
    And method PATCH
    Then status 200
    * print karate.pretty(response)
    And match response.status == true

    Given path '/api/scorer/positions/' + scorer_id
    And method GET
    Then status 200
    And match response.status == true
    And match response.data.position == 20

  @positiveCase
  Scenario: Validate  response structure Positions
    Given path '/api/scorer/positions'
    And method GET
    Then status 200
    And def scorer_id = response.data[0].id

    * eval sleep(2000)
    Given path '/api/scorer/positions/' + scorer_id
    And request { "position": 20}
    And method PATCH
    Then status 200
    * print karate.pretty(response)
    And match response.status == true

    Given path '/api/scorer/positions/' + scorer_id
    And method GET
    Then status 200
    And match response.status == true
    And match fn(response.data) contains ["id","goal_stats_id","goal_stats_json","position","created_at","updated_at","deleted_at"]


  @negativeCase
  Scenario: Validate Position: Number must be greater than or equal to 0
    Given path '/api/scorer/positions'
    And method GET
    Then status 200
    And def scorer_id = response.data[0].id

    * eval sleep(2000)
    Given path '/api/scorer/positions/' + scorer_id
    And request { "position": -20}
    And method PATCH
    Then status 400
    * print karate.pretty(response)
    And match response.status == false
    And match response.error[0] == "position : Number must be greater than or equal to 0"