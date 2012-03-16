#@selenium,@javascript
Feature: Creation of new list
  As an existing user
  I should be able to create new list
  In order to organize my tasks

  Background:
    Given I exist as a user

  @selenium,@javascript
  Scenario: Authorized user can create list with valid data
    Given I am logged in
    When I go to the new list page
    And I create new list with valid data
    Then I should see new list on list index path

  @selenium,@javascript
  Scenario: Authorized user can't create list with invalid data
    Given I am logged in
    When I go to the new list page
    And I create new list with invalid data
    Then I should see error message

  #@selenium,@javascript
 # Scenario: Authorized user can create list in the project with valid data
    #Given I am logged in
    #And I go to the new project page
    #And I create new project with valid data
    #When I go to the new list page in the project
    #And I create new list with valid data
   #Then I should see new list on list index path in the project

