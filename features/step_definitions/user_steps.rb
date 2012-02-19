def valid_user
  @user ||=  {name: "Test User", email: "test@email.com", password: "111111", password_confirmation: "111111"}
end

def sign_up user
  visit '/signup'
  fill_in "Name", with: user[:name]
  fill_in "Email", with: user[:email]
  fill_in "Password", with: user[:password]
  fill_in "Confirmation", with: user[:password_confirmation]
  click_button "Sign up"
end

def sign_in user
  visit '/signin'
  fill_in "Email", with: user[:email]
  fill_in "Password", with: user[:password]
  click_button "Sign in"
end

Given /^I am not logged in$/ do
  visit '/signout'
end

When /^I sign up with valid data$/ do
  sign_up valid_user
end

Then /^I should see a successful sign up message$/ do
  page.should have_content "Welcome!"
end

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

When /^I sign up without password confirmation$/ do
  user = valid_user.merge(password_confirmation: "")
  sign_up user
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
  visit '/signout'
end

When /^I sign in with valid data$/ do
  sign_in valid_user
end

Then /^I should see a user profile links$/ do
  page.should have_content "Profile"
  page.should have_content "Sign out"
  page.should have_content "Projects"
  page.should have_content "Lists"
end

Given /^I do not exist as a user$/ do
  User.find(:first, conditions: {email: valid_user[:email]}).should be_nil
  visit '/signout'
end

Then /^I see an invalid login message$/ do
  page.should have_content "Invalid email/password combination"
end

Then /^I should be sign out$/ do
  page.should have_content "Sign up now"
  page.should have_content "Sign in"
  page.should_not have_content "Logout"
end

When /^I return to the site$/ do
  visit '/'
end

Then /^I should be sign in$/ do
  page.should have_content "Sign out"
  page.should_not have_content "Sign up"
  page.should_not have_content "Login"
end

Given /^I am logged in$/ do
  visit '/signout'
end

When /^I sign out$/ do
  visit '/signout'
end


When /^I edit my account details$/ do
  click_link "Settings"
  fill_in "Name", with: "newname"
  fill_in "Password", with: valid_user[:password]
  click_button "Update"

end

Then /^I should see an updates profile message$/ do
  page.should have_content "Profile was updated"
end









