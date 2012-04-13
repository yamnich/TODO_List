@selenium, @javascript
Feature: Ability to select tasks by state
  As an existing user
  I should be able to select my task by state

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

  Scenario: User can select all "in work" tasks
    Given I go to the tasks page
    When I click "In work" button
    Then I see my task on the page