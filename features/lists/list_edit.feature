Feature: Ability to edit list
  As an existing user
  I should be able to edit my list

  Background:
    Given I exist as a user
    And  I sign in with valid data
    And I have a list

  Scenario: User can edit the list details with valid data
    Given I go to the lists page
    And I go to list edit page
    When I update list with valid data
    Then I should see a message "List was successfully updated"

  Scenario: User can't edit the list details with invalid data
    Given I go to the lists page
    And I go to list edit page
    When I update list with invalid data
    Then I should see name field

  Scenario: User can edit the list details in the project with valid data
    Given  I have a project
    And I have a list in project
    And I go to the projects page
    And I go to the project lists page
    And I go to list edit page
    When I update list with valid data
    Then I should see a message "List was successfully updated"

  Scenario: User can edit the list details in the project with invalid data
    Given  I have a project
    And I have a list in project
    And I go to the projects page
    And I go to the project lists page
    And I go to list edit page
    When I update list with invalid data
    Then I should see a message "List wasn't updated"



