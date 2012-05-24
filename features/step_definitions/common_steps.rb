When /^I fill in "(.*?)" with "(.*?)"$/ do |arg1, arg2|
  fill_in arg1, with: arg2
end

When /^I click "(.*?)"$/ do |arg1|
  click_on arg1
end

Then /^I should see "(.*?)"$/ do |arg1|
  page.should have_content(arg1)
end
