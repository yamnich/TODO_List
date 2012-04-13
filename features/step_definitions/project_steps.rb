def valid_project
  @project ||= {name: "Project_name"}
end

def invalid_project
  @project ||= {name: ""}
end

def create_project project
  fill_in "name", with: project[:name]
  click_button "Create Project"
end


When /^I go to the new project page$/ do
  visit '/#/projects/new'
end

When /^I create new project with valid data$/ do
   create_project valid_project
end

Then /^I should see new project on project index path$/ do
  page.should have_content @project[:name]
end

When /^I update project with valid data$/ do
  project = Project.find_by_name(valid_project[:name])
  find('.btn.btn-info.dropdown-toggle').click
  click_link("Edit project")
  fill_in "name", with: "New project"
  click_button "Update Project"
end

When /^I update project with invalid data$/ do
  project = Project.find_by_name(valid_project[:name])
  find('.btn.btn-info.dropdown-toggle').click
  click_link("Edit project")
  fill_in "name", with: ""
  click_button "Update Project"
end

When /^I delete project$/ do
  page.evaluate_script('window.confirm = function(){return true;}')
  click_link "You can"
end

When /^I create new project with invalid data$/ do
  create_project invalid_project
end

Then /^I should see an error message$/ do
  page.should have_content("Project wasn't created. Please try again")
end

Then /^I should not see a project_name$/ do
  page.should_not have_content  valid_project[:name]
end



