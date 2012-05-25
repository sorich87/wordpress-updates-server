Given /^there is one customer named "(.*?)"$/ do |arg1|
  @customer = Customer.where(name: arg1)
  @customer ||= FactoryGirl.create(:customer, name: arg1)
end

When /^I click delete$/ do
  within("#{@customer.id}") do
    click 'delete'
  end
end

Then /^I should see an alert box to confirm deletion$/ do
  page.driver.browser.switch_to.alert.accept
end

Then /^I should not see "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I confirm deletion in the alert box$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I cancel deletion in the alert box$/ do
  pending # express the regexp above with the code you wish you had
end