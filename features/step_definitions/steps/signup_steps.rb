When /^I navigate to the sign up screen$/ do
  visit signup_path
end

When /^I attempt to register a user that already exists$/ do
  fill_in "user_username", with: "Gerald"
  fill_in "user_email", with: "Gerald101@investorcaps.com"
  fill_in "user_password", with: "foobar1234"
  fill_in "user_password_confirmation", with: "foobar1234"
  click_button "Sign up"
end