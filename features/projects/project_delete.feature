Feature: Ability to delete project
  As an existing user
  I should be able to delete my projects

  Background:
    Given I exist as a user
    And   I sign in with valid data
    And I go to the new project page
    And I create new project with valid data

  @selenium,@javascript
  Scenario: User can delete the project
    When I delete project
    Then I should not see a project_name
