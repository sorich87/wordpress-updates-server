Given /^there is one package$/ do
  @package = Package.empty? ? FactoryGirl.create(:package) : Package.first
end

Then /^I should be on the edit package page$/ do
  current_path.should == edit_settings_package_path(@package)
end

Then /^I see the edit package form$/ do
  page.should have_selector("form#edit_package_#{@package.id}")
end

Then /^I see the package information filled in the fields$/ do
  page.should have_selector('input#package_name', value: @package.name)
  page.should have_selector('input#package_description', value: @package.description)
  page.should have_selector('input#package_price', value: @package.price)
  page.should have_selector('select#package_validity', value: @package.validity)
  page.should have_selector('input[name="package[billing]"]', checked: "checked", value: @package.billing)
  page.should have_selector('select#package_themes', value: @package.themes)
  page.should have_selector('input#package_domains', value: @package.domains)
end

Then /^I should not see the old package information$/ do
  pending # express the regexp above with the code you wish you had
end

# Because we show the edit form directly from the PUT UPDATE method,
# ie /package/<id>/edit becomes /package/<id> but we're still editing.
Then /^I should be on the re\-edit package page$/ do
  current_path.should == settings_package_path(@package)
end

Then /^the "(.*?)" field should contain "(.*?)"$/ do |arg1, arg2|
  find_field(arg1).value.should eq(arg2)
end

Then /^"(.*?)" should be chosen for the "(.*?)" field$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end