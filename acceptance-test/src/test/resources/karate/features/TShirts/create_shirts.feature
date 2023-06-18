Feature: Create and Delete tshirts

  Background:
    * url urlBase
    * def response_tshirts_data = read('classpath:data/tshirts/response_tshirts.json')
    * def fn = function(rsp) { return Object.keys(rsp) }

  @positiveCase
  Scenario: Create tshirts  and Delete by ID
    Given path '/api/tshirts'
    And request { "img_url": "https://www.youtube.com/watch?v=-vxdriGP1KE" }
    When method POST
    Then status 200
    And def tshirts_id = response.data.id

    Given path '/api/tshirts/' + tshirts_id
    And method DELETE
    Then status 200
    And match response.status == true


  @positiveCase
  Scenario: Validate tshirts  response structure
    Given path '/api/tshirts'
    And request { "img_url": "https://www.youtube.com/watch?v=-vxdriGP1KE" }
    When method POST
    Then status 200
    And match fn(response_tshirts_data.data) contains ["id","img_url","updated_at","created_at"]

    And def tshirts_id = response.data.id
    Given path '/api/tshirts/' + tshirts_id
    And method DELETE
    Then status 200
    And match response.status == true


  @negativeCase
  Scenario: Create tshirts with Invalid URL
    Given path '/api/tshirts'
    And request { "img_url": "h" }
    When method POST
    Then status 400
    And match response.error[0] == "img_url : Invalid url"

