#@selenium
#@javascript
Feature:
  In order to have actual user information  
  As an existing user
  I want to be able to edit my user profile

   # @selenium, @javascript
    #Scenario: Unauthorised user can't edit profile
     # Given I am not logged in
      #Then I should be sent to sign in page

  #  @selenium, @javascript
    Scenario: User edit his profile with valid data
      Given I exist as a user
      And I sign in with valid data
      When I want to edit my account details
      Then I should see success message "Profile was updated"

   # @selenium, @javascript
    Scenario: User can't edit his profile with invalid data
      Given I exist as a user
      And I sign in with valid data
      When I want to edit my account details
      Then I should see error message "There were problems with the following fields:"
      And I see users edit form