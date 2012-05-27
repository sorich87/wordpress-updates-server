When /^I fill in "(.*?)" with "(.*?)"$/ do |arg1, arg2|
  fill_in arg1, with: arg2
end

When /^I click "(.*?)"$/ do |arg1|
  click_on arg1
end

Given /^I follow "(.*?)"$/ do |arg1|
  click_on arg1
end
