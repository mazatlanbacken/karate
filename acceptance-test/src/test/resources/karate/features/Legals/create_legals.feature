Feature: Create and Delete Legal

  Background:
    * url urlBase
    * def legals_data = read('classpath:data/Legals/request_legal.json')
    * def response_legals_data = read('classpath:data/Legals/response_legal.json')
    * def fn = function(rsp) { return Object.keys(rsp) }


  @positiveCase
  Scenario: Create Legal and Delete by ID
    Given path '/api/legals'
    And request legals_data[0]
    When method POST
    Then status 200
    And def legal_id = response.data.id

    Given path '/api/legals/' + legal_id
    And method DELETE
    Then status 200
    And match response.status == true


  @positiveCase
  Scenario: Validate Legal response structure
    Given path '/api/legals'
    And request legals_data[0]
    When method POST
    Then status 200
    And match fn(response_legals_data.data) contains ["id","title_es","title_en","text_es","text_en","updated_at","created_at"]

    And def legal_id = response.data.id
    Given path '/api/legals/' + legal_id
    And method DELETE
    Then status 200
    And match response.status == true




