Feature: Get members id

  Background: Define URL
    Given url urlBase

  @positiveCase
  Scenario: Get members id
    Given path '/api/team/members'
    And method Get
    Then status 200
    And def members_id = response.data[0].id

    Given path '/api/team/members/' + members_id
    And method Get
    Then status 200
    And match response.status == true
    And match response.data.id == members_id

  @negativeCase
  Scenario: Get members with incorrect ID
    Given path '/api/team/members'
    And method GET
    Then status 200
    And def members_id = response.data[0].id

    Given def incorrect_id = "incorrect_id"
    And path '/api/team/members/' + incorrect_id
    And method GET
    Then status 200
    And match response.status == true
