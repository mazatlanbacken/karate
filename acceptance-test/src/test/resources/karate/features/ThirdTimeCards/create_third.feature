Feature: thirdTimeCards CRUD Operations

  Background:
    * url urlBase
    * def sleep = function(pause){ java.lang.Thread.sleep(pause) }

  Scenario: Create, Update, and Delete thirdTimeCard
    Given path '/api/thirdTimeCards'
    And request
    """
    {
        "title": "ejemplo",
        "banner_url": "http://ejemplo.com",
        "web_view_url": "http://ejemplo.com"
    }
    """
    When method POST
    Then status 200
    And def thirdTimeCard_id = response.data.id

    * eval sleep(2000)

    Given path '/api/thirdTimeCards/' + thirdTimeCard_id
    And method GET
    Then status 200
    And match response.data.id == thirdTimeCard_id

    * eval sleep(2000)

    Given path '/api/thirdTimeCards/' + thirdTimeCard_id
    And request
    """
    {
        "title": "ejemplo",
        "banner_url": "http://ejemplo.com",
        "web_view_url": "http://ejemplo.com"
    }
    """
    And method PATCH
    Then status 200
    And match response.data.title == "ejemplo"

    * eval sleep(2000)

    Given path '/api/thirdTimeCards/' + thirdTimeCard_id
    And method DELETE
    Then status 200
    And match response.data.id == thirdTimeCard_id
