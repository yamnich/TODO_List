Feature: Creation of new project
  As an existing user
  I should be able to create new project
  In order to organize my lists

  Background:
    Given I exist as a user
    And I am logged in

  #@selenium, @javascript
  #Scenario: Unauthorized user can't create s project
   # Given I am not logged in
   # When I go to the new project page
   # Then I should be sign out
  @selenium,@javascript
  Scenario: Authorized user can create project with valid data
    When I go to the new project page
    And I create new project with valid data
    Then I should see new project on project index path
