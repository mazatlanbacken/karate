Feature: Get token

  Background: Define URL
    Given url 'https://c7r0fy6wz3.execute-api.us-east-2.amazonaws.com/dev'
    * def token = null
    * def login_data = read('classpath:data/login.json')
    * def responseToken = null
    * def sleep = function(pause){ java.lang.Thread.sleep(pause) }

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

    * def generateRandomPhoneNumber =
  """
  function() {
    var prefix = '+5730';
    var randomNumber = '';
    for (var i = 0; i < 8; i++) {
      randomNumber += Math.floor(Math.random() * 10);
    }
    return prefix + randomNumber;
  }
  """
    Given path '/api/auth/otp/sms/send'
    And request {"phone": "+573014148410"}
    And header Content-Type = 'application/json'
    And method Post
    Then status 200
    * def responseToken = response.code
    And karate.set('tokenRegister', responseToken)
    And karate.log('Token value:', karate.get('tokenRegister'))
    * eval sleep(2000)

    Given path '/api/auth/otp/sms/verify'
    And def responseToken = karate.get('tokenRegister')
    And karate.log('Token value:', karate.get('responseToken'))
    And  request {"phone": "+573014148410", "code": "#(responseToken)"}
    And method Post
    Then status 200
    * eval sleep(2000)
    * def responseToken = response.token
    And karate.set('tokenverify', responseToken)
    And karate.log('Token value:', karate.get('tokenverify'))




  Scenario: get authentication token

    Given path '/api/auth/register'
    And  request {"name":"Test","last_name":"Test","phone":"+573014148410","birthdate":"2000-10-10","email":"anretanto@gmail.com","password":"aBc123*"}
    And eval if (karate.callSingle('classpath:karate-config.js')['useCustomAuth']) karate.configure('headers', { 'Authorization': 'Bearer ' + karate.get('tokenverify') })
    And header Authorization = 'Bearer ' + karate.get('tokenverify')
    And header Content-Type = 'application/json'
    And method Post
    Then status 200
    * def responseTokenRegister = response.access_token
    * print karate.pretty(responseTokenRegister)
    And def client_id = response.user.id
    * print karate.pretty(client_id )
    And karate.set('tokenVerifyRegister', responseTokenRegister)
    And karate.log('Register response:', karate.get('tokenVerifyRegister'))


    Given path '/api/users/' + client_id
    * def randomEmail = generateRandomEmail()
    * def phone = generateRandomPhoneNumber()
    * def useCustomAuth = false
    * def customAuth = karate.callSingle('classpath:karate-config.js')['useCustomAuth']
    And eval if (customAuth) karate.configure('headers', { 'Authorization': 'Bearer ' + karate.get('tokenVerifyRegister') })

    And  request {"name":"Test","last_name":"Test","phone":"#(phone)","birthdate":"2000-10-10","email":"#(randomEmail)","password":"aBc123*"}
    When method PATCH
    Then status 200




    Given path '/api/users/' + client_id
    And  request {"reason": "Ejemplo de ejemplof"}
    When method DELETE
    Then status 200




  @negativeCase
  Scenario: Register previously created user


    * def register_data = read('classpath:data/register_add.json')
    Given path '/api/auth/register'
    And request register_data[0]
    And eval if (karate.callSingle('classpath:karate-config.js')['useCustomAuth']) karate.configure('headers', { 'Authorization': 'Bearer ' + karate.get('tokenverify') })
    And header Authorization = 'Bearer ' + karate.get('tokenverify')
    And method Post
    Then status 400
    * karate.log('Response:', response)
    And match response.message == 'Error: This email is already registered'
    * print karate.pretty(response)

  @negativeCase
  Scenario: Register user with invalid email



    * def register_data = {"name":"Test","last_name":"Test","phone":"+51945122683","birthdate":"2000-10-10","email":"prueba12202","password":"aBc123*"}
    Given path '/api/auth/register'
    And request register_data
    And eval if (karate.callSingle('classpath:karate-config.js')['useCustomAuth']) karate.configure('headers', { 'Authorization': 'Bearer ' + karate.get('tokenverify') })
    And header Authorization = 'Bearer ' + karate.get('tokenverify')
    And method Post
    Then status 400
    * print response
    And match response.error[0] == 'email : Invalid email'
    * print karate.pretty(response)


  @negativeCase
  Scenario: Register user with invalid birth year


    * def register_data = read('classpath:data/register_add.json')
    Given path '/api/auth/register'
    And request register_data[1]
    And eval if (karate.callSingle('classpath:karate-config.js')['useCustomAuth']) karate.configure('headers', { 'Authorization': 'Bearer ' + karate.get('tokenverify') })
    And header Authorization = 'Bearer ' + karate.get('tokenverify')
    And method Post
    Then status 400
    * karate.log('Response:', response)
    And match response.error[0] == 'birthdate : Invalid'
    * print karate.pretty(response)