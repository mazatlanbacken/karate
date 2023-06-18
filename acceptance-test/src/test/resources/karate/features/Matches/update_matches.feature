Feature: Create and Delete Stadium

  Background: Define URL
    Given url urlBase
    * def match_data = read('classpath:data/matches/request_mathes.json')
    * def fn = function(rsp) { return Object.keys(rsp) }
    * def sleep = function(pause){ java.lang.Thread.sleep(pause) }
  @positiveCase
  Scenario: Update and Get Match
    Given path '/api/matches'
    And method GET
    Then status 200
    And def match_id = response.data[0].id

    * eval sleep(2000)
    Given path '/api/matches/' + match_id
    And request match_data
    And method PATCH
    Then status 200
    * print karate.pretty(response)
    And match response.status == true

    Given path '/api/matches/' + match_id
    And method GET
    Then status 200
    And match response.status == true
    And match response.data.matchday == match_data.matchday

  @positiveCase
  Scenario: Validate GET /api/matches response structure
    Given path '/api/matches'
    And method GET
    Then status 200
    And def match_id = response.data[0].id

    * eval sleep(2000)
    Given path '/api/matches/' + match_id
    And request match_data
    And method PATCH
    Then status 200
    * print karate.pretty(response)
    And match response.status == true

    Given path '/api/matches/' + match_id
    And method GET
    Then status 200
    And match response.status == true
    And match fn(response.data) contains ["id","goal_stats_id","goal_stats_json","home_team_line_up_json","away_team_line_up_json","season","matchday","match_date","created_at","updated_at","deleted_at"]
