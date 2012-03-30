Feature: Ability to select tasks by state
  As an existing user
  I should be able to select my task by state

  Background:
    Given I exist as a user
    And  I sign in with valid data
    And I have a list
    And I have a task

  Scenario: User can select all "in work" tasks
    Given I go to the tasks page
    When I click "In work" button
    Then I see my task on the page