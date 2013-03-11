Feature: User signs up to InvestorCaps

Background:
  Given I visit InvestorCaps

Scenario: I expect to not be able to register if username or email already exists
  When I navigate to the sign up screen
  And I attempt to register a user that already exists
  Then I should see "Email has already been taken"
  And I should see "Username has already been taken"