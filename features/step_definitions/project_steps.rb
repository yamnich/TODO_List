def valid_project
  @project ||= {name: "Project"}
end

def invalid_project
  @project ||= {name: ""}
end

def create_project project
  fill_in "Name", with: project[:name]
  click_button "New"
end


When /^I go to the new project page$/ do
  visit new_project_path
end

When /^I create new project with valid data$/ do
   create_project valid_project
end

Then /^I should see new project on project index path$/ do
  page.should have_content(valid_project[:name])
end

When /^I update project with valid data$/ do
  project = Project.find_by_name(valid_project[:name])
  visit edit_project_path(project)
  fill_in "Name", with: "New project"
  click_button "Update"
end

When /^I update project with invalid data$/ do
  project = Project.find_by_name(valid_project[:name])
  visit edit_project_path(project)
  fill_in "Name", with: ""
  click_button "Update"
end

When /^I delete project$/ do
  page.evaluate_script('window.confirm = function(){return true;}')
 # find('.dropdown-menu').click_link("Delete project")
  click_link "You can"
end

When /^I create new project with invalid data$/ do
  create_project invalid_project
end

Then /^I should see an error message$/ do
  page.should have_content("Project wasn't created. Please try again")
end



