@selenium
@javascript
Feature:
  In order to have actual user information  
  As an existing user
  I want to be able to edit my user profile


  Scenario: User edit his profile with valid data
    Given I exist as a user
    And I sign in with valid data
    When I want to edit my account details
    Then I should see an success message "Profile was updated"


  Scenario: User edit his profile with invalid data
    Given I exist as a user
    And I sign in with valid data
    When I want to edit my account details with invalid data
    Then I should see an error message "There were problems with the following fields:"
    And I see users edit form