When /^I go to the new list page$/ do
  visit '/lists/new'
end

When /^I create new list with name "My list"$/ do
  visit new_list_path
  fill_in "Name", with: "My list"
  click_button "New"
end
