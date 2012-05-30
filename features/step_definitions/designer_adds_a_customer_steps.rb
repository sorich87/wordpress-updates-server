Then /^I should be on the customers management page$/ do
  current_path.should == customers_path
end

When /^I go to the add customer page$/ do
  visit new_customer_path
end

When /^I add a new customer to my account$/ do
  fill_in "Email", with: "drew.allis@myemail.email"
  click_on "Save Customer"
end

Then /^I should see a success message$/ do
  page.should have_content "Customer saved"
end

Then /^I should see the customer in the list$/ do
  within "#customers-table" do
    page.should have_content "drew.allis@myemail.email"
  end
end

When /^I there is a customer in my account$/ do
  @customer = FactoryGirl.create(:customer, business: @business)
end

When /^I add that customer again$/ do
  fill_in "Email", with: @customer.email
  click_on "Save Customer"
end
