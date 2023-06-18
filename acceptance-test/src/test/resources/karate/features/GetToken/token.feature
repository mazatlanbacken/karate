Feature: Get Token

  Background:
    Given url 'https://c7r0fy6wz3.execute-api.us-east-2.amazonaws.com/dev'
    * def token = null
    * def login_data = read('classpath:data/login.json')

  Scenario: Get Authentication Token
    Given path '/api/auth/login'
    And request login_data[0]
    And header Content-Type = 'application/json'
    And method POST
    Then status 200
    And def responseToken = response.access_token
    And karate.set('token', responseToken)
    And karate.log('Token value:', karate.get('token'))
    And print 'Token received:', responseToken
    And match karate.get('token') == responseToken

