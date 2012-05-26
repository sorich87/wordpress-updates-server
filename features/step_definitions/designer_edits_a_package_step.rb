Given /^there is one package$/ do
  @business = Business.first || FactoryGirl.create(:business)
  @package = Package.where(business_id: @business.id).find(:first)
  @package ||= FactoryGirl.create(:package, business: @business)
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
  within "div##{@package.id}" do
    page.should_not have_selector('input#package_name', value: @package.name)
    page.should_not have_selector('input#package_description', value: @package.description)
    page.should_not have_selector('input#package_price', value: @package.price)
    page.should_not have_selector('select#package_validity', value: @package.validity)
    page.should_not have_selector('input[name="package[billing]"]', checked: "checked", value: @package.billing)
    page.should_not have_selector('select#package_themes', value: @package.themes)
    page.should_not have_selector('input#package_domains', value: @package.domains)
  end
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
  find_field(arg1)[:checked].should be_true
end

Then /^"(.*?)" should be selected for the "(.*?)" field$/ do |arg1, arg2|
  page.should have_select(arg2, :selected => arg1)
end