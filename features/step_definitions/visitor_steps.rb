Given /^I am a visitor without an account$/ do
end

Given /^I am on the registration page$/ do
  visit new_user_registration_path
  current_path.should == new_user_registration_path
end

When /^I fill in and submit the registration form$/ do
  business = FactoryGirl.attributes_for(:business)
  user = FactoryGirl.attributes_for(:user)
  within('#business-details') do
    fill_in 'Business Name', :with => business[:name]
    fill_in 'Business Email', :with => business[:email]
  end
  within('#user-details') do
    fill_in 'First Name', :with => user[:first_name]
    fill_in 'Last Name', :with => user[:last_name]
    fill_in 'Email Address', :with => user[:email]
    fill_in 'Password', :with => user[:password]
    fill_in 'Password Again', :with => user[:password]
  end
  click_on 'Create Account'
end

Then /^I should see a registration success message$/ do
  page.should have_content "A message with a confirmation link has been sent to your email address. Please open the link to activate your account."
end

When /^I confirm my account$/ do
  user = FactoryGirl.attributes_for(:user)
  email = user[:email]
  unread_emails_for(email).size.should == parse_email_count(1)
  open_email(email)
  visit_in_email('Confirm my account')
end

Then /^I should see a confirmation success message$/ do
  page.should have_content "Your account was successfully confirmed. You are now signed in."
end

When /^I incorrectly fill in the registration form$/ do
  business = FactoryGirl.attributes_for(:business)
  user = FactoryGirl.attributes_for(:user)
  within('#business-details') do
    fill_in 'Business Name', :with => business[:name]
    fill_in 'Business Email', :with => ''
  end
  within('#user-details') do
    fill_in 'First Name', :with => user[:first_name]
    fill_in 'Last Name', :with => user[:last_name]
    fill_in 'Email Address', :with => user[:email]
    fill_in 'Password', :with => user[:password]
    fill_in 'Password Again', :with => user[:password]
  end
  click_on 'Create Account'
end

Then /^I should see an error message$/ do
  page.should have_content "Please review the problems below:"
end
