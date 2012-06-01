When /^I go to the themes management page$/ do
  visit themes_path
end

When /^I upload a new theme$/ do
  # Useful when we need to wait for the AJAX request ot be done
  old_themes_count = page.all('ul#theme_list li.theme').length

  theme = File.join(Rails.root, 'spec/fixtures/themes/zips/annotum-base.zip')
  input = page.find('#upload_theme input[type=file]')
  attach_file input[:id], theme

  wait_until { page.all('ul#theme_list li.theme').length > old_themes_count }
end

When /^I upload a non\-valid theme archive$/ do
  theme = File.join(Rails.root, 'spec/fixtures/themes/zips/invalid/style_missing.zip')
  input = page.find('#upload_theme input[type=file]')
  attach_file input[:id], theme
end

Then /^I should see the new theme screenshot, name and version number$/ do
  page.should have_content('Annotum Base 1.0')
end

When /^I have one theme$/ do
  if @user.business.themes.empty?
    @theme = FactoryGirl.create(:theme, business: @user.business)
    @theme.should be_persisted
  end
end

When /^I delete a theme and confirm deletion$/ do
  within '#theme_list > li' do
    handle_js_confirm accept do
      click_on 'delete theme'
    end
  end
end

Then /^I should be on the themes management page$/ do
  current_path.should == themes_path
end

Then /^I should not see the theme anymore$/ do
  page.should_not have_selector("#theme-#{@theme.id}")
end

When /^I upload a new version of that theme$/ do
  theme_archive = File.join(Rails.root, 'spec/fixtures/themes/zips/annotum-base.zip')
  @theme_container = page.find("li#theme-#{@theme.id}")
  input = @theme_container.find("input[type=file]")
  attach_file input[:id], theme_archive

  wait_until { @theme_container[:'data-updated'] == 'true' }
end

Then /^I should see the new version number$/ do
  version = @theme_container.find('span.version')
  version.should have_content('1.0')
end