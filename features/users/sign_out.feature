Feature: Sign out
  To protect my data from unauthorized access
  A signed in user
  Should be able to sign out
    @selenium,@javascript
    Scenario: User sign out
      Given I exist as a user
      And I sign in with valid data
      When I sign out
      Then I should be sign out
      #When I return to the site
      #Then I should be sign out