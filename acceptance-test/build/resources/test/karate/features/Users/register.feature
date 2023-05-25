Feature: Register user

  Background: Define URL
    Given url urlBase
    * def generateRandomEmail =
      """
      function() {
        var chars = 'abcdefghijklmnopqrstuvwxyz1234567890';
        var randomString = '';
        for (var i = 0; i < 10; i++) {
          var randomIndex = Math.floor(Math.random() * chars.length);
          randomString += chars.charAt(randomIndex);
        }
        return randomString + '@example.com';
      }
      """


  @positivCase
  Scenario: Register user

    * def randomEmail = generateRandomEmail()
    * def register_data = {"fullname":"Test","nickname":"Test","shirt_number":1,"birth_year":2000,"favorite_tshirt":"163d0ac0-e053-11ed-b11e-2575f4adc39e","email":"#(randomEmail)","common_resources":["2a259390-e04e-11ed-92c3-3f632f7f5179"],"password":"123456"}
    Given path '/api/auth/register'
    And request register_data
    And method Post
    Then status 200
    And match response.message == 'The user has successfully registered'
    * print karate.pretty(response)

  @negativeCase
    Scenario: Register previously created user
      * def register_data = read('classpath:data/register_add.json')
    Given path '/api/auth/register'
      And request register_data[0]
    And method Post
    Then status 400
    And match response.message == 'Error: This email is already registered'
      * print karate.pretty(response)

  @negativeCase
  Scenario: Register user with invalid email
    * def register_data = {"fullname":"Test","nickname":"Test","shirt_number":1,"birth_year":2000,"favorite_tshirt":"163d0ac0-e053-11ed-b11e-2575f4adc39e","email":"andres","common_resources":["2a259390-e04e-11ed-92c3-3f632f7f5179"],"password":"123456"}
    Given path '/api/auth/register'
    And request register_data
    And method Post
    Then status 400
    And match response.error[0] == 'email : Invalid email'
    * print karate.pretty(response)


  @negativeCase
  Scenario: Register user with invalid birth year
    * def register_data = read('classpath:data/register_add.json')
    Given path '/api/auth/register'
    And request register_data[1]
    And method Post
    Then status 400
    And match response.error[0] == 'birth_year : Number must be greater than or equal to 0'
    * print karate.pretty(response)