When /^I make a post$/ do
  fill_in 'post_symbol', with: "LCY"
  fill_in 'post_title', with: "Announcement out!"
  fill_in 'post_content', with: "Wow great announcement out"
  click_button "Post"
end