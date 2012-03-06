def valid_project
  @project ||= {name: "Project"}
end


def create_project project
  fill_in "Name", with: project[:name]
  click_button "New"
end


When /^I go to the new project page$/ do
  visit new_project_path
end

When /^I create new project with valid data$/ do
  project = valid_project
  create_project(project)
end

Then /^I should see new project on project index path$/ do
  project =  valid_project
  page.should have_content(project[:name])
end

When /^I update project with valid data$/ do
  project_data = valid_project
  project = Project.find_by_name(project_data[:name])
  visit edit_project_path(project)
  fill_in "Name", with: "New project"
  click_button "Update"
end

When /^I update project with invalid data$/ do
  project_data = valid_project
  project = Project.find_by_name(project_data[:name])
  visit edit_project_path(project)
  fill_in "Name", with: ""
  click_button "Update"
end

When /^I delete project$/ do

  project_data = valid_project
  project = Project.find_by_name(project_data[:name])
  click_link "Delete"
end

Then /^I should not see deleted project in projects list$/ do
  pending # express the regexp above with the code you wish you had
end

