Feature: Create User Common Resource

  Background: Define URL
    Given url urlBase


  @positiveCase
  Scenario: Create and Delete User Common Resource

    Given path '/api/users'
    And method GET
    Then status 200
    And def user_id = response.data[0].id
    * print user_id

    Given path '/api/common/resources'
    And method GET
    Then status 200
    And def common_resource_id = response.data[1].id
    * print common_resource_id
    Given path '/api/users/common/resources'
    And request { "user_id": "#(user_id)", "common_resource_id": "#(common_resource_id)" }
    And method POST
    Then status 200
    And match response.status == true
    And def resource_id = response.data.id

    Given path '/api/users/common/resources/' + resource_id
    And method DELETE
    Then status 200
    And match response.status == true


