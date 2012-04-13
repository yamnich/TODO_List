#@selenium,@javascript

Feature: Creation of new list
  As an existing user
  I should be able to create new list
  In order to organize my tasks

  Background:
    Given I exist as a user
    And  I sign in with valid data

  @selenium,@javascript
  Scenario: Authorized user can create list with valid data
    When I go to the new list page
    And I create new list with valid data
    Then I should see new list on list index path

  @selenium,@javascript
  Scenario: Authorized user can't create list with invalid data
    When I go to the new list page
    And I create new list with invalid data
    Then I should see an input field

  @selenium,@javascript
  Scenario: Authorized user can create list in the project with valid data
    Given  I have a project
    And I go to the projects page
    And I go to the project lists page
    And I go to the new list page inside the project
    And I create new list with valid data
    Then I should see new list on list index path in the project

  @selenium,@javascript
  Scenario: Authorized user can create list in the project with invalid data
    Given  I have a project
    And I go to the projects page
    And I go to the project lists page
    And I go to the new list page inside the project
    And I create new list with invalid data
    Then I should see an input field

