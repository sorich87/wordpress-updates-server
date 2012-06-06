Given /^there is one package$/ do
  @theme = FactoryGirl.create(:theme, name: "A Theme", business: @user.business)
  @package = FactoryGirl.create(:package, business: @business, themes: [@theme])
end

When /^I go to the edit package page$/ do
  visit edit_package_path(@package)
end

Then /^I see the package details filled in the fields$/ do
  find_field('Package Name').value.should == @package.name
  find_field('Package Description').value.should == @package.description
  find_field('Price').value.should == @package.price
  find_field('Validity').value.should == "#{@package.validity}"
  find_field('Subscription with recurring billing').should be_checked
  find_field('A Theme').should be_checked
  find_field('Number of Themes').value.should == "#{@package.number_of_themes}"
  find_field('Number of Domains').value.should == "#{@package.number_of_domains}"
end

When /^I edit the package$/ do
  fill_in "Package Name", with: "New Name"
  fill_in "Package Description", with: "New Description"
  click_on "Save Package"
  save_and_open_page
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
