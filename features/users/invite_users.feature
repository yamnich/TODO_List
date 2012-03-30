Feature: Ability to invite users to project
  As an existing user and project owner
  I should be able to invite users to my project

  Background:
    Given I exist as a user
    And  I sign in with valid data

  Scenario: User can look through project members list
    Given I have a project
    And  I go to the projects page
    When I go to project members page
    Then I should see "Invite user" button

  Scenario: User can invite user to project
    Given I have a project
    And  I go to the projects page
    And I go to project members page
    #When I should see "Invite user" button
    And I invite user to project
    Then I see member name on project members page
