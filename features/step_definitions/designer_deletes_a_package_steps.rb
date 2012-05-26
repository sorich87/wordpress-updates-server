Given /^there is one package named "(.*?)"$/ do |arg1|
  @business = Business.first || FactoryGirl.create(:business)
  @package = Package.where(name: arg1).find(:first)
  @package ||= FactoryGirl.create(:package, name: arg1, business: @business)
  @package.should be_persisted
end

Then /^I click "(.*?)" and "(.*?)" the confirmation$/ do |arg1, arg2|
  accept = (arg2 == "accept")
  within "div##{@package.id}" do
    handle_js_confirm accept do
      click_link arg1
    end
  end
end