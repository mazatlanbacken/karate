Feature: Activities CRUD Operations

  Background:
    * url urlBase
    * def sleep = function(pause){ java.lang.Thread.sleep(pause) }

  Scenario: Create, Update, and Delete Activities
    Given path '/api/activities'
    And request
    """
    {
        "title": "ejemplo",
        "description": "ejemplo",
        "minutes": 10
    }
    """
    When method POST
    Then status 200
    And def activity_id = response.data.id
    And print 'Activity created with id:', activity_id

    * eval sleep(2000)

    Given path '/api/activities/' + activity_id
    And method GET
    Then status 200
    And match response.data.id == activity_id
    And print 'Retrieved activity with id:', activity_id

    * eval sleep(2000)

    Given path '/api/activities/' + activity_id
    And request
    """
    {
        "title": "ejemplo",
        "description": "ejemplo",
        "minutes": 10
    }
    """
    And method PATCH
    Then status 200
    And match response.data.title == "ejemplo"
    And print 'Activity updated with id:', activity_id

    * eval sleep(2000)

    Given path '/api/activities/' + activity_id
    And method DELETE
    Then status 200
    And match response.data.id == activity_id
    And print 'Activity deleted with id:', activity_id
