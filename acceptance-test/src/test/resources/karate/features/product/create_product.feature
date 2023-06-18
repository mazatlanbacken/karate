Feature: Product CRUD Operations

  Background: Define URL
    And url urlBase
    * def sleep = function(pause){ java.lang.Thread.sleep(pause) }


  Scenario: Create, Update, and Delete Product
    Given path '/api/products'
    And request
  """
  {
    "category": "FOOD",
    "price": 1020.22,
    "name": "hamburguesaPrueba",
    "section": 9
  }
  """
    When method POST
    Then status 200
    And def product_id = response.data.id

    * eval sleep(2000)

    Given path '/api/products/' + product_id
    And method GET
    Then status 200
    And match response.data.id == product_id

    * eval sleep(2000)

    Given path '/api/products/category/FOOD'
    And method GET
    Then status 200
    And match response.data[*].id contains product_id

    * eval sleep(2000)

    Given path '/api/products/' + product_id
    And request
  """
  {
    "category": "DRINKS",
    "price": 1020,
    "name": "PruebaUpdate",
    "section": 9
  }
  """
    And method PATCH
    Then status 200
    And match response.data.category == "DRINKS"

    * eval sleep(2000)

    Given path '/api/products/' + product_id
    And method DELETE
    Then status 200
    And match response.data.id == product_id
