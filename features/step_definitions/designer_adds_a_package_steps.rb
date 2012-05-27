When /^I go to the packages management page$/ do
  visit settings_packages_path
end

When /^I see the add package form$/ do
  page.should have_selector('form#new_package')
end

When /^I select "(.*?)" as "(.*?)"$/ do |arg1, arg2|
  select arg1, from: arg2
end

When /^I choose "(.*?)" as "(.*?)"$/ do |arg1, arg2|
  choose arg1
end

Then /^I should be on the packages management page$/ do
  current_path.should eq(settings_packages_path)
end

Then /^I should not see the add package form$/ do
  find('form#new_package').should_not be_visible
end
