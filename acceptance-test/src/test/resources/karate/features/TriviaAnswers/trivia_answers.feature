Feature: Validate Error Message

  Background:
    * url urlBase

  Scenario: Validate Error Message of /api/trivia/answers
    Given path '/api/trivia/answers'
    And request
    """
    {
        "match_id": "c52ba6e0-f10b-11ed-bc92-9b2d1c01e966",
        "answers": [
            {
                "question_id": "34a2b790-0bd6-11ee-abf0-ebc61f5d8e54",
                "answer": true
            }
        ]
    }
    """
    When method Post
    Then status 400
    And match response.error.message == "Error: Answers exist"


  Scenario: Validate Error Message of /api/trivia/answers
    Given path '/api/trivia/answers'
    And request
    """
    {
        "match_id": "c52ba6e0-f10b-11ed-bc92-9b2d1c01e966",
        "answers": [
            {
                "question_id": "invalid_uuid",
                "answer": true
            }
        ]
    }
    """
    When method Post
    Then status 400
    And match response.status == false
    And match response.error contains "answers,0,question_id : Invalid uuid"


  Scenario: Validate Error Message of /api/trivia/answers
    Given path '/api/trivia/answers'
    And request
    """
    {
        "match_id": "c52ba6e0-f10b-11ed-bc92-9b2d1c01e966",
        "answers": [
            {
                "question_id": "34a2b790-0bd6-11ee-abf0-ebc61f5d8e54",
                "answer": "true"
            }
        ]
    }
    """
    When method POST
    Then status 400
    And match response.status == false
    And match response.error contains "answers,0,answer : Expected boolean, received string"


  Scenario: Validate Response Structure of /api/trivia/answers
    * def fn = function(rsp) { return Object.keys(rsp) }
    Given path '/api/trivia/answers'
    When method GET
    Then status 200
    And match response.status == true
    And match fn(response.data[0]) contains ["id", "trivia_question_id", "user_id", "answer", "is_correct", "created_at", "updated_at", "deleted_at"]