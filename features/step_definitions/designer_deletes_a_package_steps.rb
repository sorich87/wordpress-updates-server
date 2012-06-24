Given /^there is one package named "(.*?)"$/ do |arg1|
  @package = @business.packages.where(name: arg1).first
  @package ||= Fabricate(:package, name: arg1, business: @business)
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
