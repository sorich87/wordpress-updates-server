Given /^I am a visitor without an account$/ do
end

Given /^the following account exists:$/ do |table|
  table.hashes.each do |h|
    @business = Business.new(:business_name => h.business_name, :account_name => h.account_name)
    @user = User.new(:first_name => h.first_name, :last_name => h.last_name, :email => h.email,
             :password => h.password, :password_confirmation => h.password)
    @user.confirm!
  end
end

When /^I go to the registration page$/ do
  visit new_user_registration_path
end
