When /^I go to the customers management page$/ do
  visit customers_path
end

Given /^there is one customer with email "(.*?)"$/ do |email|
  @customer = @business.customers.where(email: email).first
  @customer ||= Fabricate(:customer, email: email, businesses: [@business])
end

Then /^I click on delete and "(.*?)" the confirmation$/ do |arg1|
  accept = (arg1 == "accept")
  handle_js_confirm accept do
    within "tr##{@customer.id}" do
      click_on "Delete"
    end
  end
end
