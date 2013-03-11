When /^I navigate to the sign in screen$/ do
  visit signin_path
end

When /^I login as a user$/ do
  fill_in "user_email",    with: "cameronbradley.git@gmail.com"
  fill_in "user_password", with: "test1234"
  click_button "Sign in"
end