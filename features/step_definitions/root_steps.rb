Given /^I am on InvestorCaps$/ do
  visit "http://localhost:3000/"
end

Then /^I should see the title "(.*)"$/ do |title|
  assert_equal title, page.find(:css, 'title').text
end