Given /^there is one package$/ do
  @package = FactoryGirl.create(:package_with_themes, business: @business)
end

When /^I go to the edit package page$/ do
  visit edit_settings_package_path(@package)
end

Then /^I see the package details filled in the fields$/ do
  page.should have_selector('input#package_name', value: @package.name)
  page.should have_selector('input#package_description', value: @package.description)
  page.should have_selector('input#package_price', value: @package.price)
  page.should have_selector('select#package_validity', value: @package.validity)
  page.should have_selector('input[name="package[billing]"]', checked: "checked", value: @package.billing)
  page.should have_selector('input#package_number_of_themes', value: @package.number_of_themes)
  page.should have_selector('input#package_number_of_domains', value: @package.number_of_domains)
end

When /^I edit the package$/ do
  fill_in "Package Name", with: "New Name"
  fill_in "Package Description", with: "New Description"
  click_on "Save Package"
end

Then /^I should see the new package details$/ do
  page.should have_content "New Name"
  page.should have_content "New Description"
end

Then /^I should not see the old package details/ do
  within "div##{@package.id}" do
    page.should_not have_selector('input#package_name', value: @package.name)
    page.should_not have_selector('input#package_description', value: @package.description)
  end
end
