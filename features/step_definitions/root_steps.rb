Given /^I visit InvestorCaps$/ do
  visit root_path
end

Then /^I should see the title "(.*)"$/ do |title|
  assert_equal title, page.find(:css, 'title').text
end