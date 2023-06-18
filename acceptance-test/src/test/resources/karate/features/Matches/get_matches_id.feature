Feature: Get Matches  id

  Background: Define URL
    Given url urlBase

  @positiveCase
  Scenario: Get match by ID
    Given path '/api/matches'
    And method GET
    Then status 200
    And def match_id = response.data[0].id

    Given path '/api/matches/' + match_id
    And method GET
    Then status 200
    And match response.status == true
    And match response.data.id == match_id

  @negativeCase
  Scenario: Get match with incorrect ID
    Given path '/api/matches'
    And method GET
    Then status 200
    And def match_id = response.data[0].id

    Given def incorrect_id = "incorrect_id"
    And path '/api/matches/' + incorrect_id
    And method GET
    Then status 200
    And match response.status == true


  @positiveCase
  Scenario: Get Latest Match
    Given path '/api/matches/latest'
    And method GET
    Then status 200
    And match response.status == true
    And match response.data.id != null
    And match response.data.goal_stats_id != null
    And match response.data.goal_stats_json != null
    And match response.data.season != null
    And match response.data.matchday != null
    And match response.data.match_date != null
    And match response.data.created_at != null
    And match response.data.updated_at != null
    And match response.data.deleted_at == null
