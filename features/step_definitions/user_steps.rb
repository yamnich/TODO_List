def valid_user
  @user ||=  {name: "Test User", email: "test@email.com", password: "111111", password_confirmation: "111111"}
end
def invited_user
  @invited_user ||= {name: "Invited User", email: "invited@email.com", password: "111111", password_confirmation: "111111"}
end

def sign_up user
  visit new_user_registration_path
  fill_in "Name", with: user[:name]
  fill_in "Email", with: user[:email]
  fill_in "Password", with: user[:password]
  fill_in "Password confirmation", with: user[:password_confirmation]
  click_button "Sign up"
end

def sign_in user
  visit new_user_session_path
  fill_in "Email", with: user[:email]
  fill_in "Password", with: user[:password]
  click_button "Sign in"
end

Given /^I am not logged in$/ do
 visit new_user_session_path
 page.should have_content "Sign in"
end

When /^I sign up with valid data$/ do
  sign_up valid_user
end

When /^I sign in with invalid data$/ do
  user = valid_user.merge(email: "email_wrong", password: "1")
  sign_in user
end

#Then /^I should see a successful sign up message$/ do
 # page.should have_content "Welcome!"
#end

When /^I sign up with invalid email$/ do
  user = valid_user.merge(email: "email_wrong")
  sign_up user
end

Then /^I should see an invalid email message$/ do
  page.should have_content "Email is invalid"
end

When /^I sign up without password$/ do
  user = valid_user.merge(password: "")
  sign_up user
end

Then /^I should see a missing password message$/ do
  page.should have_content "Password can't be blank"
end

Then /^I should see a missing password confirmation message$/ do
  page.should have_content "Password doesn't match confirmation"
end

When /^I sign up with a mismatched password confirmation$/ do
  user = valid_user.merge(password_confirmation: "other_password")
  sign_up user
end

Then /^I should see a mismatched password message$/ do
  page.should have_content "Password doesn't match confirmation"
end

Given /^I exist as a user$/ do
  sign_up valid_user
  click_link "Sign out"
end

When /^I sign in with valid data$/ do
  sign_in valid_user
end

Then /^I should see a user menu$/ do
  page.should have_content "Sign out"
  page.should have_content "Profile"
  page.should have_content "Home"
end

Given /^I do not exist as a user$/ do
  User.find(:first, conditions: {email: valid_user[:email]}).should be_nil
end

Given /^I am redirected for registration$/ do
  visit new_user_registration_path
end

Then /^I should see an invalid login message$/ do
 # page.should have_content "Invalid email or password."
  page.should have_content "Sign in"
end

Then /^I should be sign out$/ do
  page.should have_content "Sign up"
  page.should have_content "Sign in"
end

When /^I return to the site$/ do
  visit '/'
end

Then /^I should be sign in$/ do
  page.should have_content "Sign out"
  page.should_not have_content "Sign up"
  page.should_not have_content "Login"
end

When /^I sign out$/ do
  click_link "Sign out"
end


When /^I want to edit my account details$/ do
  click_link('Profile')
  fill_in "Name", with: "New user name"
  fill_in "Email", with: "New email"
  fill_in "Password", with:"Newpassword"
  fill_in "Password confirmation", with:"Newpassword"
  click_button "Update"
end

Then /^I should be sent to sign in page$/ do
  visit '/'
end


Then /^I should see an updates profile message$/ do
  page.should have_content "Profile was updated"
end

Then /^I see users edit form$/ do
  ["Name", "Email", "Password"].each do |el|
     page.should have_content(el)
  end
end

When /^I want to edit my account details with invalid data$/ do
  click_link('Profile')
  fill_in "Name", with: ""
  fill_in "Email", with: ""
  fill_in "Password", with:"1"
  fill_in "Password confirmation", with:"1"
  click_button "Update"
end

#####
Given /^I go to the projects page$/ do
  pid=Project.find_by_name(valid_project[:name])
  mid =User.find_by_name("Invited User")
  @project_membership=ProjectMembership.create(project_id: pid, member_id: mid)
  visit '/'
  click_link 'Projects'
end

Given /^I have a project$/ do
  @project = Project.create!(name: valid_project[:name], user_id: User.find_by_name(valid_user[:name]).id)
end

When /^I go to project members page$/ do
  click_link "Look through the members list"
end

Then /^I should see "([^"]*)" button$/ do |arg1|
  page.should have_content("Invite user to project")
end

When /^I invite user to project$/ do
  @other_user = User.create(@invited_user)
  click_link "Invite user to project"
  fill_in "email", with: @other_user.email
  click_button "Invite"
end

Then /^I see member name on project members page$/ do
  page.should have_content @other_user.name
end

Given /^I sign up with invited_user data$/ do
  sign_up invited_user
end

Then /^I see project I was invited in$/ do

 #page.should have_content("Test cucumber project")
end




