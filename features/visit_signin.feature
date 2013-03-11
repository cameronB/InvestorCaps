Feature: User signs into InvestorCaps

Background:
  Given I visit InvestorCaps

Scenario: when I signin i expect to be on the home page
  When I navigate to the signin screen
  And I login as a user
  Then I should see the title "InvestorCaps | Home"