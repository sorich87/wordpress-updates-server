other_name = "Some other business"
other_email = "other.email@example.com"

Given /^a business$/ do
  @business = FactoryGirl.create(:business)
end

When /^I edit its details$/ do
  visit '/settings/business/edit'
  fill_in 'business_name', with: other_name
  fill_in 'business_email', with: other_email
end

Then /^those details should be updated$/ do
  @business.reload
  @business.name.should eq(other_name)
  @business.email.should eq(other_email)
end

Then /^the business details should not change$/ do
  old_business = @business
  @business.reload

  @business.should eq(old_business)
end


When /^click on "(.*?)"$/ do |arg1|
  click_on arg1
end