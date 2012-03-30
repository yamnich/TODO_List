#@selenium
#@javascript

Feature: Sign up
  In order to get access to site
  As a user
  I want to be able to sign up

  Background:
    Given I am not logged in

  Scenario: User signs up with valid data
    When I sign up with valid data
    Then I should see an success message "Welcome! You have signed up successfully."

  Scenario: User signs up with invalid email
    When I sign up with invalid email
    Then I should see an error message "Email is invalid"

  Scenario: User signs up without password
    When I sign up without password
    Then I should see an error message "Password can't be blank"

  Scenario: User signs up with mismatched password and confirmation
    When I sign up with a mismatched password confirmation
    Then I should see an error message "Password doesn't match confirmation"