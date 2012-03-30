Then /^I should see an error message "([^"]*)"$/ do |arg1|
  page.should have_content  "Name"
end

Then /^I should see an success message "([^"]*)"$/ do |arg1|
  page.should_not have_content "Profile was updated"
end