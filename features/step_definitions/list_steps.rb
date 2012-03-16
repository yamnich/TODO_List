def valid_list
  @list ||= {name: "My list"}
end

def create_list list
  fill_in "Name", with: list[:name]
  click_button "New"
end



When /^I go to the new list page$/ do
  visit '/lists/new'
end

When /^I create new list with valid data$/ do

  visit '/lists/new'
  create_list valid_list
end

Then /^I should see new list on list index path$/ do
 page.should have_content("My list")

end

When /^I go to the new list page in the project$/ do
  project = valid_project
  my_project = Project.find_by_name(project[:name])
  visit new_project_list_path(my_project)
end

Then /^I should see new list on list index path in the project$/ do
  project = valid_project
  my_project = Project.find_by_name(project[:name])
  visit project_lists_path(my_project)
  page.should have_content("My list")

end

When /^I create new list with invalid data$/ do
  list=valid_list.merge(name: "")
  create_list list
end

Then /^I should see error message$/ do
  pending # express the regexp above with the code you wish you had
end

