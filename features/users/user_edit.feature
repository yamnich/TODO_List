#@selenium
#@javascript
Feature:
  As a registered user
  I want to edit my user profile


    Scenario: I sign in and edit my account
      Given I am logged in
      When I edit my account details
      Then I should see an updates profile message