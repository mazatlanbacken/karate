Feature: Update and Delete Resource

  Background: Define URL
    Given url urlBase
    * def fn = function(rsp) { return Object.keys(rsp) }
    * def sleep = function(pause){ java.lang.Thread.sleep(pause) }

  @positiveCase
  Scenario: Create, Update and Delete T-Shirt
    Given path '/api/tshirts'
    And request { "img_url": "https://www.youtube.com/watch?v=-vxdriGP1KE" }
    When method POST
    Then status 200
    * print karate.pretty(response)
    And def tshirt_id = response.data.id
    * print karate.pretty(tshirt_id)

    * eval sleep(2000)
    Given path '/api/tshirts/' + tshirt_id
    And request { "img_url": "https://prueba.com" }
    And method PATCH
    Then status 200
    * print karate.pretty(response)
    And match response.status == true


    * eval sleep(2000)
    Given path '/api/tshirts/' + tshirt_id
    And method GET
    Then status 200
    And match response.data.img_url == "https://prueba.com"

    * eval sleep(2000)
    Given path '/api/tshirts/' + tshirt_id
    And method DELETE
    Then status 200
    And match response.status == true


