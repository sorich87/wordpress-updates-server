def handle_js_confirm(accept=true)
  page.evaluate_script "window.original_confirm_function = window.confirm"
  page.evaluate_script "window.confirm = function(msg) { return #{!!accept}; }"
  yield
ensure
  page.evaluate_script "window.confirm = window.original_confirm_function"
end

Then /^I should not see "(.*?)"$/ do |arg1|
  page.should_not have_content(arg1)
end

Given /^I signed in to my business account$/ do
  # TODO: Implement business accounts
  # Skip it for now, but make sure we have a business account
  Business.first.destroy unless Business.first.nil?
  @business = Business.create(
    name: "Themes For You",
    email: "ythemes@themes.thm"
  )
end

Then /^screenshot this to "(.*?)"$/ do |arg1|
  page.driver.render arg1
end

# This seems to break syntax highlighting in at least Sublime Text 2 :)
Then /^I should see "([^"]+)"$/ do |arg1|
  page.should have_content(arg1)
end