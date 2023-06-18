Feature: Trivia Questions CRUD Operations

  Background:
    * url urlBase
    * def sleep = function(pause){ java.lang.Thread.sleep(pause) }

  Scenario: Create, Retrieve, and Delete Trivia Question
    Given path '/api/trivia/questions'
    And request
    """
    {
        "match_id": "7c1837b0-f64d-11ed-8e8d-2b2a34d6ba30",
        "question": "¿Pregunta Karate?"
    }
    """
    When method POST
    Then status 200
    And def question_id = response.data.id

    * eval sleep(2000)

    Given path '/api/trivia/questions/' + question_id
    And method GET
    Then status 200
    And match response.data.id == question_id

    * eval sleep(2000)

    Given path '/api/trivia/questions/match/' + response.data.match_id
    And method GET
    Then status 200
    And match response.data[0].id == question_id

    * eval sleep(2000)

    Given path '/api/trivia/questions/' + question_id
    And method DELETE
    Then status 200
    And match response.data.id == question_id


  Scenario: Validate Response Structure of /api/trivia/questions/match/:slug/calculate
    Given path '/api/trivia/questions/match/c52ba6e0-f10b-11ed-bc92-9b2d1c01e966/calculate'
    And method GET
    Then status 200

    And def fn = function(rsp) { return Object.keys(rsp) }
    And match fn(response.data[0]) contains ["id", "trivia_question_id", "user_id", "answer", "is_correct", "created_at", "updated_at", "deleted_at", "trivia_question"]
    And match fn(response.data[0].trivia_question) contains ["id", "match_id", "question", "correct_answer", "created_at", "updated_at", "deleted_at"]



  Scenario: Validate Response Structure of /api/trivia/questions/match/:slug/rank
    Given path '/api/trivia/questions/match/c52ba6e0-f10b-11ed-bc92-9b2d1c01e966/rank'
    And method GET
    Then status 200

    And def fn = function(rsp) { return Object.keys(rsp) }
    And match fn(response.data[0]) contains ["user_id", "score", "score_percentage", "user", "position"]
    And match fn(response.data[0].user) contains ["name", "last_name", "birthdate", "email", "phone"]



  Scenario: Validate Response Structure of /api/trivia/questions
    Given path '/api/trivia/questions'
    When method GET
    Then status 200
    And match response.status == true
    And def fn = function(rsp) { return Object.keys(rsp) }
    And match fn(response.data[0]) contains ["id", "match_id", "question", "correct_answer", "created_at", "updated_at", "deleted_at"]
    And match fn(response.data[1]) contains ["id", "match_id", "question", "correct_answer", "created_at", "updated_at", "deleted_at"]