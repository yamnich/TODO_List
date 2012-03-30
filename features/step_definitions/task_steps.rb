def valid_task
  @task ||= {name: "My task"}
end

def create_task task
  fill_in "Name", with: task[:name]
  click_button "New"
end

def update_task name
  fill_in "Name", with: name
  click_button "Update"
end


When /^I go to the tasks page$/ do
  visit list_tasks_path(@list)
end

When /^I go to the new task page$/ do
  click_link "Add the task"
end

When /^I create new task with valid data$/ do
  create_task valid_task
end

When /^I create new task with invalid data$/ do
  valid_task.merge(name: "")
  create_task valid_task
end

Given /^I have a task$/ do
  @task=Task.create!(name: valid_task[:name],list_id: @list.id, priority: "1")
end

Given /^I go to task edit page$/ do
 click_link "Edit task"
end

When /^I update task with valid data$/ do
  update_task "New name task"
end

When /^I update task with invalid data$/ do
  update_task ""
end


