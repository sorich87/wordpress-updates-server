When /^I delete my account$/ do
  visit admin_settings_business_path
  click_on "I want to delete my account"
end

Then /^I should see a modal window to confirm deletion$/ do
  find("#delete-account").visible?
end

When /^I confirm deletion of my account$/ do
  within "#delete-account" do
    fill_in "delete-password", with: @user.password
    click_on "delete-confirm"
  end
end

Then /^I should be on the sorry to see you go page$/ do
  current_path.should == sorry_home_path
end

Then /^all my account data should be deleted$/ do
  Business.where(_id: @business.id).length.should == 0
end
