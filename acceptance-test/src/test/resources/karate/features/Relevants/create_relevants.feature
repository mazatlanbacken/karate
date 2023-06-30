Feature: CRUD Operations for /api/relevants

  Background:
    * url urlBase
    * def sleep = function(pause){ java.lang.Thread.sleep(pause) }

  Scenario: Create, Get, Update, and Delete relevant
    Given path '/api/relevants'
    And request
    """
    {
        "image_url": "http://image.com/image.jpg",
        "title_es": "ejemplo",
        "title_en": "ejemplo",
        "highlight_es": "ejemplo",
        "highlight_en": "ejemplo",
        "content_es": "ejemplo",
        "content_en": "ejemplo"
    }
    """
    When method POST
    Then status 200
    And def relevant_id = response.data.id
    And print 'Created relevant with ID:', relevant_id

    * eval sleep(2000)

    Given path '/api/relevants/' + relevant_id
    And method GET
    Then status 200
    And match response.data.id == relevant_id
    And print 'Retrieved relevant with ID:', relevant_id

    * eval sleep(2000)

    Given path '/api/relevants'
    And method GET
    Then status 200
    And match response.data[*].id contains relevant_id
    And print 'All relevants:', response.data

    * eval sleep(2000)

    Given path '/api/relevants/' + relevant_id
    And request
    """
    {
        "image_url": "http://image.com/image",
        "title_es": "ejemplo",
        "title_en": "ejemplo",
        "highlight_es": "ejemplo",
        "highlight_en": "ejemplo",
        "content_es": "3",
        "content_en": "3"
    }
    """
    And method PATCH
    Then status 200
    And match response.data.id == relevant_id
    And match response.data.image_url == "http://image.com/image"
    And print 'Updated relevant with ID:', relevant_id

    * eval sleep(2000)

    Given path '/api/relevants/' + relevant_id
    And method DELETE
    Then status 200
    And match response.data.id == relevant_id
    And print 'Deleted relevant with ID:', relevant_id

  Scenario: Validate response structure
    Given path '/api/relevants'
    And method GET
    Then status 200

    # Define the function to extract keys from the response
    * def fn = function(rsp) { return Object.keys(rsp) }

    # Validate the keys in the 'data' array of the response
    And match fn(response.data[0]) contains ["id", "image_url", "title_es", "title_en", "highlight_es", "highlight_en", "content_es", "content_en", "created_at", "updated_at", "deleted_at"]
