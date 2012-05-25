# Background:
Given /^I signed in to my business account$/ do
  # TODO: Implement business accounts
  # Skip it for now, but make sure we have a business account
  Business.first.destroy unless Business.first.nil?
  @business = Business.create(
    name: "Themes For You",
    email: "ythemes@themes.thm"
  )
end

When /^I go to the packages management page$/ do
  visit settings_packages_path
end

When /^I click "(.*?)"$/ do |arg1|
  click_on arg1
end

When /^I see the add package form$/ do
  page.should have_selector('form#new_package')
end

When /^I fill in "(.*?)" with "(.*?)"$/ do |arg1, arg2|
  fill_in arg1, with: arg2
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

Then /^I should see "(.*?)"$/ do |arg1|
  page.should have_content(arg1)
end

