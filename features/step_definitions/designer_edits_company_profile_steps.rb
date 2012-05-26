When /^I go to the edit company profile page$/ do
  visit settings_business_path
end

When /^the "(.*?)" field contains "(.*?)"$/ do |arg1, arg2|
  find_field(arg1).value.should eq(arg2)
end

Then /^I should be on the edit company profile page$/ do
  current_path.should == settings_business_path
end