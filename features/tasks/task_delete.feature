Feature: Ability to delete task
  As an existing user
  I should be able to delete my task

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

  @selenium,@javascript
  Scenario: User can delete the task
    When I delete the task
    Then I should see an success message "Task was successfully deleted"