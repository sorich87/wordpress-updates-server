Given /^I am a confirmed user$/ do
end

When /^I sign in$/ do
  user = FactoryGirl.create(:designer)
  visit new_user_session_path
  fill_in "Email Address", with: user.email
  fill_in "Password", with: user.password
  click_on "Log in"
end

Then /^I should be on the themes listing page$/ do
  current_path.should eq(root_path)
end

Given /^I am signed in$/ do
  step 'I sign in'
end

Then /^I should be on the login page$/ do
  current_path.should eq(new_user_session_path)
end
