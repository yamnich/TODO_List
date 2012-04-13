@selenium
@javascript

Feature: Ability to edit task
  As an existing user
  I should be able to edit my task

  Background:
    Given I exist as a user
    And  I sign in with valid data
    And I have a list
    And I go to the new list page
    And I create new list with valid data
    And I have a task
    And I go to the tasks page
    And I go to the new task page
    And I create new task with valid data
    And I go to the tasks page

  Scenario: User can edit the task details with valid data
    And I go to task edit page
    When I update task with valid data
    Then I should see an success message "Task was successfully updated"

  Scenario: User can edit the task details with invalid data
    And I go to task edit page
    When I update task with invalid data
    Then I should see an success message "Task is not updated"

  Scenario: User can change task state
    When I change the task state
    Then I should see an success message "Task was successfully updated"
    And I should see changed task state