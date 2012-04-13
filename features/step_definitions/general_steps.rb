Then /^I should see an error message "([^"]*)"$/ do |arg1|
  page.should have_content  "Name"
end

Then /^I should see an success message "([^"]*)"$/ do |arg1|
  page.should_not have_content "Profile was updated"
end

Then /^(?:|I )should see a message "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

Then /^I should see a "([^"]*)"$/ do |arg1|
  page.should have_content arg1
end
