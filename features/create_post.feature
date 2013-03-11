Feature: User makes a post

Background:
  Given I am logged into InvestorCaps as a user

Scenario: I expect to be able to create a post
  When I make a post
  Then I should see "Post created!"
