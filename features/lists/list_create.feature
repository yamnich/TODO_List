#@selenium,@javascript
Feature: Creation of new list
  As an existing user
  I should be able to create new list
  In order to organize my tasks

  Background:
    Given I exist as a user

  #Scenario: Unauthorized user can't create list
   # Given I am not logged in
    #When I go to the new list page
    #Then I sign out

  @selenium,@javascript
  Scenario: Authorized user can create list with valid data
    When I go to the new list page
    And I create new list with valid data
    Then I should see new list on list index path
