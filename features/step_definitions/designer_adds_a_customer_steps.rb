Given /^there is a package named "(.*?)"$/ do |arg1|
  package = @business.packages.where(name: arg1).find(:first)
  if package.blank?
    package = FactoryGirl.attributes_for(:package).merge(name: arg1)
    @business.packages.create!(package)
  end
end

Given /^there is a customer with email "(.*?)"$/ do |arg1|
  customer = @business.customers.where(email: arg1).find(:first)
  if customer.blank?
    customer = FactoryGirl.attributes_for(:customer).merge(email: arg1)
    @business.customers.create!(customer)
  end
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
