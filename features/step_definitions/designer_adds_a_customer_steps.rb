Given /^there is a package named "(.*?)"$/ do |arg1|
  @package = Package.where(name: arg1).find(:first)
  @package ||= FactoryGirl.create(:package, name: arg1)
  @package.should be_persisted
end

Given /^there is a customer with email "(.*?)"$/ do |arg1|
  @customer = Customer.where(email: arg1).find(:first)
  @customer ||= FactoryGirl.create(:customer, email: arg1)
  @customer.should be_persisted
end

When /^I go to the customers management page$/ do
  visit customers_path
end

Then /^I should be on the add customer page$/ do
  current_path.should == new_customer_path
end

Then /^I should be on the customers management page$/ do
  current_path.should == customers_path
end

Then /^"(.*?)" should be selected as "(.*?)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see "(.*?)" in the column "(.*?)"$/ do |arg1, arg2|
  
end