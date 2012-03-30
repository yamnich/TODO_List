#@selenium, @javascript
Feature: Sign in
  In order to get access to site
  As a user
  I want to be able to sign in

  Scenario: User signs in with valid data
    Given I exist as a user
    And I am not logged in
    When I sign in with valid data
    Then I should see a user menu

  Scenario: User is not signed up
    Given I do not exist as a user
    When I sign in with valid data
    Then I should see an invalid login message

  Scenario: User signs in successfully with email
    Given I exist as a user
    And I am not logged in
    When I sign in with valid data
    Then I should see a user menu
    Then I should be sign in

  Scenario: User signs in with invalid data
    Given I exist as a user
    And I am not logged in
    When I sign in with invalid data
    Then I should see an invalid login message
