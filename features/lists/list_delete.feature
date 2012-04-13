Feature: Ability to delete list
  As an existing user
  I should be able to delete my list

  Background:
    Given I exist as a user
    And   I sign in with valid data
    And I have a list
    And I go to the lists page

  @selenium,@javascript
  Scenario: User can delete the list
    When I delete list
    Then I should not see list