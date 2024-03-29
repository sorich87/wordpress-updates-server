When /^I go to the packages management page$/ do
  visit packages_path
end

When /^I add a package$/ do
  @package = Fabricate.attributes_for(:package)
  click_on "Add a package"
  fill_in "Package Name", with: @package[:name]
  fill_in "Package Description", with: @package[:description]
  fill_in "Price", with: @package[:price]
  fill_in "Validity", with: @package[:validity]
  choose "One time payment"
  fill_in "Number of Extensions", with: @package[:number_of_extensions]
  fill_in "Number of Domains", with: @package[:number_of_domains]
  check @theme.name
  click_on "Save Package"
end

Then /^I should be on the packages management page$/ do
  current_path.should == packages_path
end

Then /^I should see the package details$/ do
  page.should have_content @package[:name]
  page.should have_content @package[:description]
end
