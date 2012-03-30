Feature: Ability to edit task
  As an existing user
  I should be able to edit my task

  Background:
    Given I exist as a user
    And  I sign in with valid data
    And I have a list
    And I have a task

  Scenario: User can edit the task details with valid data
    Given I go to the tasks page
    And I go to task edit page
    When I update task with valid data
    Then I should see an success message "Task was successfully updated"


  Scenario: User can't edit the task details with valid data
    Given I go to the tasks page
    And I go to task edit page
    When I update task with invalid data
    Then I should see an success message "Task is not updated"