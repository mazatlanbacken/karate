Feature: CRUD Operations for /api/news

  Background:
    * url urlBase
    * def sleep = function(pause){ java.lang.Thread.sleep(pause) }

  Scenario: Create, Get, Update, and Delete news
    Given path '/api/news'
    And request
    """
    {
        "image_url": "http://image.com/image.jpg",
        "title_es": "ejemplo",
        "title_en": "ejemplo",
        "abstract_es": "ejemplo",
        "abstract_en": "ejemplo",
        "content_es": "ejemplo",
        "content_en": "ejemplo"
    }
    """
    When method POST
    Then status 200
    And def news_id = response.data.id
    And print 'Created news with ID:', news_id

    * eval sleep(2000)

    Given path '/api/news/' + news_id
    And method GET
    Then status 200
    And match response.data.id == news_id
    And print 'Retrieved news with ID:', news_id

    * eval sleep(2000)

    Given path '/api/news'
    And method GET
    Then status 200
    And match response.data[*].id contains news_id
    And print 'All news:', response.data

    * eval sleep(2000)

    Given path '/api/news/' + news_id
    And request
    """
    {
        "image_url": "http://image.com/image.jpg",
        "title_es": "ejemplo",
        "title_en": "ejemplo",
        "abstract_es": "ejemplo",
        "abstract_en": "ejemplo",
        "content_es": "ejemplo",
        "content_en": "ejemplo"
    }
    """
    And method PATCH
    Then status 200
    And match response.data.id == news_id
    And match response.data.image_url == "http://image.com/image.jpg"
    And print 'Updated news with ID:', news_id

    * eval sleep(2000)

    Given path '/api/news/' + news_id
    And method DELETE
    Then status 200
    And match response.data.id == news_id
    And print 'Deleted news with ID:', news_id



  Scenario: Validate response structure
    Given path '/api/news'
    And method GET
    Then status 200

    # Define the function to extract keys from the response
    * def fn = function(rsp) { return Object.keys(rsp) }

    # Validate the keys in the 'data' array of the response
    And match fn(response.data[0]) contains ["id", "image_url", "title_es", "title_en", "abstract_es", "abstract_en", "content_es", "content_en", "created_at", "updated_at", "deleted_at"]