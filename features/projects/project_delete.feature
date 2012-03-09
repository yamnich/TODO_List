Feature: Ability to delete project
  As an existing user
  I should be able to delete my projects

  Background:
    Given I exist as a user
    And I am logged in
    And I go to the new project page
    And I create new project with valid data
  @selenium,@javascript
  Scenario: User can delete the project
    When I delete project
    Then I should see success message "Project was successfully deleted"
