When /^I fill in "(.*?)" with "(.*?)"$/ do |arg1, arg2|
  fill_in arg1, with: arg2
end

When /^I click "(.*?)"$/ do |arg1|
  click_on arg1
end

Given /^I follow "(.*?)"$/ do |arg1|
  click_on arg1
end

Then /^I should see a success message "(.*?)"$/ do |arg1|
  page.find('div.alert-notice').should have_content(arg1)
end

When /^I select "(.*?)" as "(.*?)"$/ do |arg1, arg2|
  select arg1, from: arg2
end

When /^I choose "(.*?)" as "(.*?)"$/ do |arg1, arg2|
  choose arg1
end
