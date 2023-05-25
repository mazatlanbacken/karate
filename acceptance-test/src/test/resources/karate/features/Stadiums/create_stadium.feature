Feature: Create and Delete Stadium

  Background: Define URL
    Given url urlBase
    * def stadiums_data = read('classpath:data/stadiums/stadiums.json')
    * def fn = function(rsp) { return Object.keys(rsp) }

  @positiveCase
  Scenario: Create and Delete Stadium
    Given path '/api/stadiums'
    And request stadiums_data[0]
    When method Post
    Then status 200
    * print karate.pretty(response)
    And def stadium_id = response.data.id

    Given path '/api/stadiums/' + stadium_id
    And method DELETE
    Then status 200
    And match response.status == true
    And match response.data == 1


  @positiveCase
  Scenario: Validate Stadium response structure
    * def response_stadiums_data = read('classpath:data/stadiums/response_stadiums.json')
    Given path '/api/stadiums'
    And request stadiums_data[0]
    When method Post
    Then status 200
    * print karate.pretty(response)
    And match fn(response_stadiums_data.data) contains ["id","infographic_url","text_first_es","text_first_en","stadium_image_url","address_es","address_en","capacity","text_second_es","text_second_en","latitude","longitude","updated_at","created_at"]


  @negativeCase
  Scenario: Create Stadium with Negative Capacity
    Given path '/api/stadiums'
    And request stadiums_data[1]
    When method POST
    Then status 400
    And match response.error[0] == "capacity : Number must be greater than or equal to 0"

  @negativeCase
  Scenario: Create Stadium with invalid infographic url
    Given path '/api/stadiums'
    And request stadiums_data[2]
    When method POST
    Then status 400
    And match response.error[0] == "infographic_url : Invalid url"

  @negativeCase
  Scenario: Create Stadium with invalid stadium_image_url
    Given path '/api/stadiums'
    And request stadiums_data[3]
    When method POST
    Then status 400
    And match response.error[0] == "stadium_image_url : Invalid url"