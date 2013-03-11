Feature: User signs into InvestorCaps

Background:
  Given I visit InvestorCaps

Scenario: when I sign in i expect to be signed in successfully
  When I navigate to the sign in screen
  And I login as a user
  Then I should see "Signed in successfully."