def valid_list
  @list ||= {name: "My list"}
end

def create_list list
  fill_in "name", with: list[:name]
  click_button "Create List"
end

def update_list name
  fill_in "name", with: name
  click_button "Update List"
end

When /^I go to the new list page$/ do
  visit '/#/lists/new'
end

When /^I create new list with valid data$/ do
  create_list valid_list
end

Then /^I should see new list on list index path$/ do
 page.should have_content("My list")

end

When /^I go to the new list page in the project$/ do
  project = Project.find_by_name(valid_project[:name])
  click_link project.name
  click_link "New list"
end

Then /^I should see new list on list index path in the project$/ do
  visit '/#/projects'
  project = valid_project
  my_project = Project.find_by_name(project[:name])
  click_link my_project.name
  page.should have_content("My list")

end

When /^I create new list with invalid data$/ do
  list=valid_list.merge(name: "")
  create_list list
end

Given /^I go to the project lists page$/ do
  click_link (valid_project[:name])
end

Given /^I go to the new list page inside the project$/ do
  click_link "New list"
end

Then /^I should see new list on project list index path$/ do
  page.should have_content("My list")

end

Given /^I have a list$/ do
  @list=Factory.create(:list, name: valid_list[:name], user_id: User.find_by_name(valid_user[:name]).id)
end

Given /^I go to list edit page$/ do
  find('.btn.btn-info.dropdown-toggle').click
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
  visit root_path
  click_link "Lists"
end

When /^I delete list$/ do
  find('.btn.btn-info.dropdown-toggle').click
  click_link("Delete list")
end

Given /^I have a list in project$/ do
  @list=List.create!(name: valid_list[:name], user_id: User.find_by_name(valid_user[:name]).id, project_id: Project.find_by_name(valid_project[:name]).id)
end

Then /^I should see an input field$/ do
  page.should have_selector(:xpath, "//input[@type='text' and @name='name']")
end


Then /^I should not see list$/ do
  page.should_not have_content(valid_list[:name])
end


