Given /^I visit InvestorCaps$/ do
  visit root_path
end

Given /^I am logged into InvestorCaps as a user$/ do
  visit signin_path
  fill_in "user_email",    with: "cameronbradley.git@gmail.com"
  fill_in "user_password", with: "test1234"
  click_button "Sign in"
  page.should have_content("Signed in successfully.")
end

Then /^I should see the title "(.*)"$/ do |title|
  assert_equal title, page.find(:css, 'title').text
end

Then /^I should see "(.*)"$/ do |content|
  page.should have_content(content)
end