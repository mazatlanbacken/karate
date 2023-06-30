Feature: User Notifications

  Background: Define URL
    Given url urlBase
    * def userId = '0d606f50-151e-11ee-b1ef-6fe0bf76f753'

  Scenario: Create and Retrieve User Notifications

    # Create user notifications
    Given path 'api/users/' + userId + '/notifications'
    And request
    """
    {
        "notifications": [
            {
                "common_resource_id": "acbcf920-1540-11ee-be3f-8ff43c13d7cd",
                "active": false
            },
            {
                "common_resource_id": "acbcf920-1540-11ee-be3f-8ff43c13d7cd",
                "active": false
            }
        ]
    }
    """
    And method POST
    Then status 200
    * def createdNotifications = response.data

    # Retrieve user notifications
    Given path 'api/users/' + userId + '/notifications'
    And method GET
    Then status 200
    * def retrievedNotifications = response.data

      # Verify at least one created notification is present in retrieved notifications
    * def notificationPresent = karate.filter(retrievedNotifications, function(notification){ return createdNotifications.some(function(created){ return created.id === notification.id }) }).length
    * assert notificationPresent > 0


