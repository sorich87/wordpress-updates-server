When /^I go to the plugins management page$/ do
  visit plugins_path
end

When /^I upload a new plugin$/ do
  old_plugins_count = page.all('ul#theme_list li.theme').length

  plugin = File.join(Rails.root, 'spec/fixtures/plugins/zips/acobot.1.1.2.zip')
  input = page.find('#upload_extension input[type=file]')
  attach_file input[:id], plugin

  wait_until { page.all('ul#extension_list li.plugin').length > old_plugins_count }
end

Then /^I should see the new plugin screenshot, name and version number$/ do
  page.should have_content('Acobot Live Chat Robot 1.1.2')
end

When /^I upload a non\-valid plugin archive$/ do
  plugin = File.join(Rails.root, 'spec/fixtures/plugins/zips/invalid/missing_name.zip')
  input = page.find('#upload_extension input[type=file]')
  attach_file input[:id], plugin
end

When /^I have one plugin$/ do
  @user.business.plugins.destroy_all
  @plugin = Fabricate(:plugin, name: 'Acobot Live Chat Robot 1.1.2', 
                               business: @user.business, current_version: '0.1')
  @plugin.should be_persisted
end

When /^I upload a new version of that plugin$/ do
  plugin_archive = File.join(Rails.root, 'spec/fixtures/plugins/zips/acobot.1.1.2.zip')
  @plugin_container = page.find("li#extension-#{@plugin.id}")
  input = @plugin_container.find("input[type=file]")
  attach_file input[:id], plugin_archive

  wait_until {
    page.find("li#extension-#{@plugin.id}")[:'data-updated'] == 'true'
  }
end

Then /^I should see the new plugin version number$/ do
  @plugin_container.should have_content('1.1.2')
end

When /^I delete a plugin and confirm deletion$/ do
  within "#extension-#{@plugin.id}" do
    handle_js_confirm do
      click_on 'delete plugin'
    end
  end
end

Then /^I should be on the plugins management page$/ do
  current_path.should == plugins_path
end

Then /^I should not see the plugin anymore$/ do
  page.should_not have_selector("#extension-#{@plugin.id}")
end
