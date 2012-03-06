#@selenium, @javascript

Feature: Sign in
  In order to get access to site
  As a user
  I want to be able to sign in

  Scenario: User signs in with valid data
    Given I exist as a user
    And I am not logged in
    When I sign in with valid data
    Then I should see a user profile links

  Scenario: User is not signed up
    Given I do not exist as a user
    When I sign in with valid data
    Then I see an invalid login message
    And I should be sign out

  Scenario: User signs in successfully with email
    Given I exist as a user
    And I am not logged in
    When I sign in with valid data
    Then I should see a user profile links
    When I return to the site
    Then I should be sign in