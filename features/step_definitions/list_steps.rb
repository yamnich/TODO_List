def valid_list
  @list ||= {name: "My list"}
end

def create_list list
  fill_in "Name", with: list[:name]
  click_button "Create List"
end

def update_list name
  fill_in "Name", with: name
  click_button "Update List"
end

When /^I go to the new list page$/ do
  visit '/lists/new'
end

When /^I create new list with valid data$/ do
  create_list valid_list
end

Then /^I should see new list on list index path$/ do
 page.should have_content("My list")

end

When /^I go to the new list page in the project$/ do
  project = Project.find_by_name(valid_project[:name])
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

#Then /^I should see error message$/ do
 # page.should have_content "List wasn't created"
#end

Given /^I go to the project lists page$/ do
  click_link (valid_project[:name])
end

Given /^I go to the new list page inside the project$/ do
  click_link "Add the list to the project"

end

Then /^I should see new list on project list index path$/ do
  page.should have_content("My list")

end

Given /^I have a list$/ do
  @list=List.create!(name: valid_list[:name], user_id: User.find_by_name(valid_user[:name]).id)
end

Given /^I go to list edit page$/ do
  click_link("Edit list")
end

When /^I update list with valid data$/ do
  update_list "New list name"
end

When /^I update list with invalid data$/ do
 update_list ""
end

Then /^I should see name field$/ do
  page.should have_content "Name"
end

Given /^I go to the lists page$/ do
  click_link "Lists"
end

When /^I delete list$/ do
  page.evaluate_script('window.confirm = function(){return true;}')
  click_link "You can"
end

Given /^I have a list in project$/ do
  @list=List.create!(name: valid_list[:name], user_id: User.find_by_name(valid_user[:name]).id, project_id: Project.find_by_name(valid_project[:name]).id)
end






