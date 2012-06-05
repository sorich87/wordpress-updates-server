When /^I go to the packages management page$/ do
  visit settings_packages_path
end

When /^I add a package$/ do
  @package = attributes_for(:package)
  click_on "Add a package"
  fill_in "Package Name", with: @package[:name]
  fill_in "Package Description", with: @package[:description]
  fill_in "Price", with: @package[:price]
  select "Lifetime", from: "Validity"
  choose "One time payment"
  fill_in "Number of Themes", with: @package[:number_of_themes]
  fill_in "Number of Domains", with: @package[:number_of_domains]
  check @theme.name
  click_on "Save Package"
end

Then /^I should be on the packages management page$/ do
  current_path.should == settings_packages_path
end

Then /^I should see the package details$/ do
  page.should have_content @package[:name]
  page.should have_content @package[:description]
end
