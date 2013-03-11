Feature: User visits InvestorCaps

Background:
  Given I visit InvestorCaps

Scenario: The home page title is as expected
  Then I should see the title "InvestorCaps | Home"