Feature: Create and Delete histories
  Background:
    * url urlBase
    * def histories_data = read('classpath:data/histories/request_histories.json')
    * def response_histories_data = read('classpath:data/histories/response_histories.json')
    * def fn = function(rsp) { return Object.keys(rsp) }

  @positiveCase
  Scenario: Create histories and Delete by ID
    Given path '/api/histories'
    And request histories_data[0]
    When method POST
    Then status 200
    And def histories_id = response.data.id

    Given path '/api/histories/' + histories_id
    And method DELETE
    Then status 200
    And match response.status == true
    And match response.data == 1

  @positiveCase
  Scenario: Validate histories response structure
    Given path '/api/histories'
    And request histories_data[0]
    When method POST
    Then status 200
    And match fn(response_histories_data.data) contains ["id","video_url","text_es","text_en","updated_at","created_at"]

    And def histories_id = response.data.id
    Given path '/api/histories/' + histories_id
    And method DELETE
    Then status 200
    And match response.status == true
    And match response.data == 1


  @negativeCase
  Scenario: Create histories with Invalid URL
    Given path '/api/histories'
    And request histories_data[1]
    When method POST
    Then status 400
    And match response.error[0] == "video_url : Invalid url"

