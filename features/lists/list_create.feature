#@selenium,@javascript
Feature: Creation of new list
  As an existing user
  I should be able to create new list
  In order to organize my tasks

  Scenario: Unauthorized user can't create list
    Given I am not logged in
    When I go to the new list page
    Then I sign out

  Scenario: Authorized user can create list with the name
    Given I am logged in
    When I go to the new list page
    And I create new list with name "My Project"
    Then A project "My List" should exist
    And I should visit lists path
    And I should see "My List" on lists path
