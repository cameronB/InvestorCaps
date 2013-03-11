Feature: User signs up to InvestorCaps

Background:
  Given I visit InvestorCaps

Scenario: I expect to be able to register to InvestorCaps
  When I navigate to the sign up screen
  And I register a new user
  Then I should see "Welcome! You have signed up successfully."