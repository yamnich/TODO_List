Feature: Ability to edit project
  As an existing user
  I should be able to edit my projects

  Background:
    Given I exist as a user
    And I am logged in
    And I go to the new project page
    And I create new project with valid data

  Scenario: User can edit the project details with valid data
    When I update project with valid data
    Then I should see success message "Project was successfully updated"

  Scenario: User can't edit the project details with invalid data
    When I update project with invalid data
    Then I should see error message "Project wasn't updated"
