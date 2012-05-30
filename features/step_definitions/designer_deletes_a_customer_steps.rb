When /^I go to the customers management page$/ do
  visit customers_path
end

Given /^there is one customer named "(.*?)"$/ do |arg1|
  (first_name, last_name) = arg1.split(' ')
  @customer = Customer.where(first_name: first_name).where(last_name: last_name)
              .where(business_id: @business.id).find(:first)
  @customer ||= FactoryGirl.create(:customer, first_name: first_name, last_name: last_name, business: @business)
end

Then /^I click on delete and "(.*?)" the confirmation$/ do |arg1|
  accept = (arg1 == "accept")
  handle_js_confirm accept do
    within "tr##{@customer.id}" do
      click_on "Delete"
    end
  end
end
