Feature: Create and Delete team

  Background:
    * url urlBase
    * def team_data = read('classpath:data/team/request_team.json')
    * def response_team_data = read('classpath:data/team/response_team.json')
    * def fn = function(rsp) { return Object.keys(rsp) }
    * def sleep = function(pause){ java.lang.Thread.sleep(pause) }



  @positiveCase
  Scenario: Update and Delete team

    Given path '/api/team/members'
    And method Get
    Then status 200
    And def members_id = response.data[0].id


    * eval sleep(2000)
    Given path '/api/team/members/' + members_id
    And request team_data[0]
    And method PATCH
    Then status 200
    * print karate.pretty(response)
    And match response.status == true


    Given path '/api/team/members/' + members_id
    And method Get
    Then status 200
    And match response.status == true
    And match response.data.goals == team_data[0].goals


  @positiveCase
  Scenario: Validate team response structure
    Given path '/api/team/members'
    And method Get
    Then status 200
    And def members_id = response.data[0].id


    * eval sleep(2000)
    Given path '/api/team/members/' + members_id
    And request team_data[0]
    And method PATCH
    Then status 200
    * print karate.pretty(response)
    And match response.status == true


    Given path '/api/team/members/' + members_id
    And method Get
    Then status 200
    And match response.status == true
    And match response.data.image_url == team_data[0].image_url
    And match fn(response_team_data.data) contains ["id","goal_stats_id","goal_stats_json","image_url","instagram_url","twitter_url","height","weight","age","games_played","minutes_played","goals","yellow_cards","red_cards","updated_at","created_at"]




  @negativeCase
  Scenario: Create Team with Negative Games Played titutar
    Given path '/api/team/members'
    And method Get
    Then status 200
    And def members_id = response.data[0].id
    * eval sleep(2000)
    Given path '/api/team/members/' + members_id
    And request team_data[1]
    When method PATCH
    Then status 400
    And match response.error[0] == "games_played_titutar : Number must be greater than or equal to 0"


  @negativeCase
  Scenario: Create Team with negative age
    Given path '/api/team/members'
    And method Get
    Then status 200
    And def members_id = response.data[0].id
    * eval sleep(2000)
    Given path '/api/team/members/' + members_id
    And request team_data[3]
    When method PATCH
    Then status 400
    And match response.error[0] == "age : Number must be greater than or equal to 0"

  @negativeCase
  Scenario: Create Team with negative games_played
    Given path '/api/team/members'
    And method Get
    Then status 200
    And def members_id = response.data[0].id
    * eval sleep(2000)
    Given path '/api/team/members/' + members_id
    And request team_data[4]
    When method PATCH
    Then status 400
    And match response.error[0] == "games_played : Number must be greater than or equal to 0"


  @negativeCase
  Scenario: Create Team with negative minutes played
    Given path '/api/team/members'
    And method Get
    Then status 200
    And def members_id = response.data[0].id
    * eval sleep(2000)
    Given path '/api/team/members/' + members_id
    And request team_data[5]
    When method PATCH
    Then status 400
    And match response.error[0] == "minutes_played : Number must be greater than or equal to 0"

  @negativeCase
  Scenario: Create Team with negative goals
    Given path '/api/team/members'
    And method Get
    Then status 200
    And def members_id = response.data[0].id
    * eval sleep(2000)
    Given path '/api/team/members/' + members_id
    And request team_data[6]
    When method PATCH
    Then status 400
    And match response.error[0] == "goals : Number must be greater than or equal to 0"

  @negativeCase
  Scenario: Create Team with negative yellow_cards
    Given path '/api/team/members'
    And method Get
    Then status 200
    And def members_id = response.data[0].id
    * eval sleep(2000)
    Given path '/api/team/members/' + members_id
    And request team_data[7]
    When method PATCH
    Then status 400
    And match response.error[0] == "yellow_cards : Number must be greater than or equal to 0"

  @negativeCase
  Scenario: Create Team with negative red_cards
    Given path '/api/team/members'
    And method Get
    Then status 200
    And def members_id = response.data[0].id
    * eval sleep(2000)
    Given path '/api/team/members/' + members_id
    And request team_data[8]
    When method PATCH
    Then status 400
    And match response.error[0] == "red_cards : Number must be greater than or equal to 0"


  @negativeCase
  Scenario: Create Team with Invalid url
    Given path '/api/team/members'
    And method Get
    Then status 200
    And def members_id = response.data[0].id
    * eval sleep(2000)
    Given path '/api/team/members/' + members_id
    And request team_data[9]
    When method PATCH
    Then status 400
    And match response == { "status": false, "error": ["image_url : Invalid url", "instagram_url : Invalid url", "twitter_url : Invalid url"] }
