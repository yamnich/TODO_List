Feature: Creation of new task
  As an existing user
  I should be able to create new task

  Background:
    Given I exist as a user
    And  I sign in with valid data
    And I have a list
    And I go to the new list page
    And I create new list with valid data


  @selenium,@javascript
  Scenario: Authorized user can create task with valid data
    When I go to the tasks page
    And I go to the new task page
    And I create new task with valid data
    Then I should see an success message "Task was successfully created"


  @selenium,@javascript
  Scenario: Authorized user can create task with invalid data
    When I go to the tasks page
    And I go to the new task page
    And I create new task with invalid data
    Then I should see an success message "Task was successfully created"