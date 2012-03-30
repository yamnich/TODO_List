Feature: Access to project invited in
  As an existing user and project member
  I should be able to manage

  Scenario: Invited can get access to project invited in
  Given I sign up with invited_user data
  When I go to the projects page
  Then I see project I was invited in