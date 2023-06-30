Feature: Service Integration Test

  Background:
    Given url 'https://c7r0fy6wz3.execute-api.us-east-2.amazonaws.com/dev'
    * def token = null
    * def responseCode = null
    * def sleep = function(pause){ java.lang.Thread.sleep(pause) }


  Scenario: Integration Test

    # Send OTP via email
    Given path '/api/auth/otp/email/send'
    And request {"email": "test45573@example.com"}
    And header Content-Type = 'application/json'
    And method Post
    Then status 200
    * def responseCode = response.code
    And karate.set('otpCode', responseCode)
    And karate.log('OTP code:', karate.get('otpCode'))
    * eval sleep(2000)

    # Verify OTP via email
    Given path '/api/auth/otp/email/verify'
    And request {"email": "test45573@example.com", "code": "#(otpCode)"}
    And header Content-Type = 'application/json'
    And method Post
    Then status 200
    * eval sleep(2000)
    * def responseToken = response.token
    And karate.set('verificationToken', responseToken)
    And karate.log('Verification token:', karate.get('verificationToken'))

    # Reset password
    Given path '/api/auth/resetPassword'
    And request {"email": "hansgianfranco@gmail.com", "password": "aBc123*"}
    And eval if (karate.callSingle('classpath:karate-config.js')['useCustomAuth']) karate.configure('headers', { 'Authorization': 'Bearer ' + karate.get('verificationToken') })
    And header Authorization = 'Bearer ' + karate.get('verificationToken')
    And header Content-Type = 'application/json'
    And method Post
    Then status 200
    * def responseMessage = response.data.message
    And karate.log('Reset password message:', responseMessage)
    * def responseEmail = response.data.email
    And karate.log('Reset password email:', responseEmail)
