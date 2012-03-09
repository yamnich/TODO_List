def valid_list
  @list ||= {name: "List"}
end

def create_project project
  fill_in "Name", with: project[:name]
  click_button "New"
end

When /^I go to the new list page$/ do
  visit new_list_path
end

When /^I create new list with valid data$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see new list on list index path$/ do
  pending # express the regexp above with the code you wish you had
end
